import cv2
import numpy as np


def remove_semi_transparent_pixels(image_path, output_path):
    # Load the image with alpha channel
    img = cv2.imread(image_path, cv2.IMREAD_UNCHANGED)
    if img is None:
        raise ValueError("Image not found or unable to load.")

    # Ensure image has an alpha channel
    if img.shape[2] < 4:
        raise ValueError("Image does not have an alpha channel.")

    # Get the alpha channel
    alpha = img[:, :, 3]

    # Create a mask to keep only pixels with alpha > 199
    mask = (alpha > 50).astype(np.uint8) * 255

    # Apply mask to alpha channel
    img[:, :, 3] = mask

    # Save the result
    cv2.imwrite(output_path, img)


# Example usage:
# remove_semi_transparent_pixels("input.png", "output.png")

# Example usage
# remove_background_shadow("input.png", "output.png")

# function that iterates over all files in dir and removes semi-transparent pixels
# overwrites the original file
def remove_semi_transparent_pixels_from_dir(dir_path):
    import os
    for filename in os.listdir(dir_path):
        if filename.endswith(".png"):
            remove_semi_transparent_pixels(os.path.join(dir_path, filename), os.path.join(dir_path, filename))


if __name__ == '__main__':
    remove_semi_transparent_pixels_from_dir(r'C:\Users\buk\Downloads\wtf_files\deicards\ui\units\icons')
