import tensorflow as tf
import cv2
import os
import numpy as np


vocab = [x for x in "abcdefghijklmnopqrstuvwxyz'?!123456789 "]
char_to_num = tf.keras.layers.StringLookup(vocabulary=vocab, oov_token="")
num_to_char = tf.keras.layers.StringLookup(
    vocabulary=char_to_num.get_vocabulary(), oov_token="", invert=True
)

def CTCLoss(y_true, y_pred):
    batch_len = tf.cast(tf.shape(y_true)[0], dtype="int64")
    input_length = tf.cast(tf.shape(y_pred)[1], dtype="int64")
    label_length = tf.cast(tf.shape(y_true)[1], dtype="int64")

    input_length = input_length * tf.ones(shape=(batch_len, 1), dtype="int64")
    label_length = label_length * tf.ones(shape=(batch_len, 1), dtype="int64")

    loss = tf.keras.backend.ctc_batch_cost(y_true, y_pred, input_length, label_length)
    return loss


def load_video(path:str): 

    cap = cv2.VideoCapture(path)
    frames = []
    for _ in range(int(cap.get(cv2.CAP_PROP_FRAME_COUNT))): 
        ret, frame = cap.read()
        frame = tf.image.rgb_to_grayscale(frame)
        frames.append(frame[190:236,80:220,:])
    cap.release()
    
    mean = tf.math.reduce_mean(frames)
    std = tf.math.reduce_std(tf.cast(frames, tf.float32))
    return tf.cast((frames - mean), tf.float32) / std

def load_alignments(path:str): 
    with open(path, 'r') as f: 
        lines = f.readlines() 
    tokens = []
    for line in lines:
        line = line.split()
        if line[2] != 'sil': 
            tokens = [*tokens,' ',line[2]]
    return char_to_num(tf.reshape(tf.strings.unicode_split(tokens, input_encoding='UTF-8'), (-1)))[1:]

def load_data(path: str): 
    path = bytes.decode(path.numpy())
    #file_name = path.split('/')[-1].split('.')[0]
    # File name splitting for windows
    file_name = path.split('\\')[-1].split('.')[0]
    video_path = os.path.join('data','s1',f'{file_name}.mpg')
    alignment_path = os.path.join('data','alignments','s1',f'{file_name}.align')
    frames = load_video(video_path) 
    alignments = load_alignments(alignment_path)
    
    return frames, alignments

def add_empty_frames(input_video_path, output_video_path, target_frame_count=75):
    cap = cv2.VideoCapture(input_video_path)

    # Get video properties
    fps = cap.get(cv2.CAP_PROP_FPS)
    width = int(cap.get(cv2.CAP_PROP_FRAME_WIDTH))
    height = int(cap.get(cv2.CAP_PROP_FRAME_HEIGHT))

    # Calculate current frame count
    current_frame_count = int(cap.get(cv2.CAP_PROP_FRAME_COUNT))

    # Calculate the number of empty frames to add
    empty_frame_count = max(0, target_frame_count - current_frame_count)

    # Create VideoWriter object for the output video
    fourcc = cv2.VideoWriter_fourcc(*'mp4v')  # You can change the codec as needed
    out = cv2.VideoWriter(output_video_path, fourcc, fps, (width, height))

    # Read and write existing frames
    while True:
        ret, frame = cap.read()
        if not ret:
            break
        out.write(frame)

    # Add empty frames
    for _ in range(empty_frame_count):
        empty_frame = np.zeros((height, width, 3), dtype=np.uint8)
        out.write(empty_frame)

    # Release video capture and writer objects
    cap.release()
    out.release()
    

def split_video(input_video_path, output_video_prefix, batch_size=75):
    cap = cv2.VideoCapture(input_video_path)

    # Get video properties
    fps = cap.get(cv2.CAP_PROP_FPS)
    width = int(cap.get(cv2.CAP_PROP_FRAME_WIDTH))
    height = int(cap.get(cv2.CAP_PROP_FRAME_HEIGHT))
    os.makedirs(output_video_prefix)
    # Create VideoWriter object for the output videos
    fourcc = cv2.VideoWriter_fourcc(*'mp4v')  # You can change the codec as needed

    batch_count = 0
    while True:
        # Read frames for the current batch
        frames = []
        for _ in range(batch_size):
            ret, frame = cap.read()
            if not ret:
                break
            frames.append(frame)

        if not frames:
            break

        # Check if the last batch needs padding
        if len(frames) < batch_size:
            # Add empty frames to reach the desired batch size
            empty_frames_count = batch_size - len(frames)
            for _ in range(empty_frames_count):
                frames.append(np.zeros((height, width, 3), dtype=np.uint8))

        # Write frames to the output video
        output_video_path = f"{output_video_prefix}/video_batch{batch_count}.mp4"
        out = cv2.VideoWriter(output_video_path, fourcc, fps, (width, height))
        for frame in frames:
            out.write(frame)
        out.release()

        batch_count += 1

    # Release video capture object
    cap.release()