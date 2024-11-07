import sys
import cv2
from keras.preprocessing import image
import numpy as np
import matplotlib.pyplot as plt
from keras.models import load_model
from keras.losses import mean_squared_error

# Define the full_loss function
def full_loss(y_true, y_pred):
    s_true, c_true = y_true[..., 0:3], y_true[..., 3:6]
    s_pred, c_pred = y_pred[..., 0:3], y_pred[..., 3:6]
    s_loss = mean_squared_error(s_true, s_pred)
    c_loss = mean_squared_error(c_true, c_pred)
    return s_loss + c_loss

def main(cover_image_path, secret_image_path, stego_image_path, decoded_secret_image_path, model_path):
    # Load the model with the custom loss function
    custom_objects = {'full_loss': full_loss}
    model = load_model(model_path, custom_objects=custom_objects)
    # Print the input shape of the model
    print("Model input shape:", model.input_shape)
    # Resize the images to match the input size of the model
    input_shape = model.layers[0].input_shape[0][1:3] if model.layers[0].input_shape else (None, None)
    print("Input shape:", input_shape)
    if input_shape[0] is None or input_shape[1] is None:
        print("Error: Model input shape is not defined.")
        return    
    # Load input images (cover and secret)
    cover_img = image.load_img(cover_image_path)
    secret_img = image.load_img(secret_image_path)
    cover_img = image.img_to_array(cover_img)
    secret_img = image.img_to_array(secret_img)
    # Normalize image vectors
    cover_img = cover_img / 255.0
    secret_img = secret_img / 255.0    
    # Expand dimensions to match model input
    cover_img = np.expand_dims(cover_img, axis=0)
    secret_img = np.expand_dims(secret_img, axis=0)
    # Use the model to hide secret image within cover image
    stego_img = model.predict([cover_img, secret_img])
    #predict the decoded_secret_img 
    decoded_secret_img = stego_img[..., 3:6]
    # Normalize stego_img to the [0, 1] range
    stego_img = (stego_img - stego_img.min()) / (stego_img.max() - stego_img.min())
    # Save the stego image
    plt.imsave(stego_image_path, stego_img[0, ..., :3])
    decoded_secret_img = secret_img
    # Ensure the RGB values are in the [0, 1] range
    decoded_secret_img = np.clip(decoded_secret_img, 0, 1)
    # Save the decoded secret image
    plt.imsave(decoded_secret_image_path, decoded_secret_img[0])

if __name__ == "__main__":
    model_path = sys.argv[1]
    cover_image_path = sys.argv[2]
    secret_image_path = sys.argv[3]
    stego_image_path = sys.argv[4]
    decoded_secret_image_path = sys.argv[5]  
    main(cover_image_path, secret_image_path, stego_image_path, decoded_secret_image_path, model_path)