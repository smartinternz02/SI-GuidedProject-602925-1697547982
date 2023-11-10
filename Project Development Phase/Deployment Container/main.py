from flask import Flask, jsonify, request
import tensorflow as tf
import os,shutil
from utils import load_data,load_video,add_empty_frames,num_to_char,CTCLoss,split_video

model = tf.keras.models.load_model("./LipReading.keras",custom_objects={"CTCLoss":CTCLoss})
app = Flask(__name__)
def predict(video_path):
    test_path = video_path
    print(test_path)
    sample = load_video(test_path)

    if(len(sample)<75):
        print("Frames < 75")
        add_empty_frames(test_path,"output.mp4",75)
        test_path = "output.mp4"
        sample = load_video(test_path)
        y_pred = model.predict(tf.expand_dims(sample, axis=0))
        decoded = tf.keras.backend.ctc_decode(y_pred, input_length=[75], greedy=True)[0][0].numpy()
        final_pred = tf.strings.reduce_join(num_to_char(decoded)).numpy().decode('utf-8')
    elif(len(sample)>75):
        print("Frames >75")
        split_video(test_path,"output_75")
        vals=[]
        for i in os.listdir("output_75"):
            # print(i)
            sample = load_video(f"output_75/{i}")
            vals.append(sample)
        final_pred=""
        for i in vals:
            yhat = model.predict(tf.expand_dims(i, axis=0))
            decoded = tf.keras.backend.ctc_decode(yhat, input_length=[75], greedy=True)[0][0].numpy()
            preds = tf.strings.reduce_join(num_to_char(decoded)).numpy().decode('utf-8')
            # print(final_pred)
            final_pred+=f"{preds} "
        shutil.rmtree("output_75")
    else:
        y_pred = model.predict(tf.expand_dims(sample, axis=0))
        decoded = tf.keras.backend.ctc_decode(y_pred, input_length=[75], greedy=True)[0][0].numpy()
        final_pred = tf.strings.reduce_join(num_to_char(decoded)).numpy().decode('utf-8')

    print(final_pred)
    return final_pred

@app.route('/predict', methods=['POST','GET'])
def prediction_endpoint():
    if 'file' not in request.files:
        return jsonify({'error': 'No file part'})

    file = request.files['file']

    if file.filename == '':
        return jsonify({'error': 'No selected file'})

    try:
        video_path = "uploaded_video.mp4"
        file.save(video_path)
        result = predict(video_path)
        os.remove(video_path)  # Remove the uploaded video after processing
        return jsonify({'prediction': result})

    except Exception as e:
        return jsonify({'error': str(e)})


if __name__ == '__main__':
    app.run(debug=True)
