import os
from plyfile import PlyData, PlyElement
import numpy as np

def is_color_close(color1, color2, tolerance):
    # Check if two colors are within the specified tolerance
    return np.all(np.abs(color1 - color2) <= tolerance)

def replace_color_in_ply(file_path, target_color, replacement_color, tolerance):
    if not os.path.isfile(file_path):
        print(f"Error: The file does not exist: {file_path}")
        return
    
    try:
        # Load the PLY file
        ply_data = PlyData.read(file_path)
    except Exception as e:
        print(f"Error reading PLY file: {e}")
        return

    # Access the vertex data
    vertex_data = ply_data['vertex']
    
    # Extract the colors and convert to a NumPy array
    colors = np.array([vertex_data['red'], vertex_data['green'], vertex_data['blue']]).T
    
    # Create a mask for colors close to the target color
    target_color = np.array(target_color)
    mask = np.array([is_color_close(color, target_color, tolerance) for color in colors])
    
    # Replace the colors
    if mask.any():
        print(f"Replacing {np.sum(mask)} vertices close to color {target_color} with {replacement_color} in {file_path}.")
        vertex_data['red'][mask] = replacement_color[0]
        vertex_data['green'][mask] = replacement_color[1]
        vertex_data['blue'][mask] = replacement_color[2]
    
    # Create a new NumPy array for the modified vertex data
    modified_vertices = np.zeros(vertex_data.count, dtype=[
        ('x', 'float32'), 
        ('y', 'float32'), 
        ('z', 'float32'),
        ('red', 'uint8'), 
        ('green', 'uint8'), 
        ('blue', 'uint8'),
        ('alpha', 'uint8')
    ])
    
    # Fill the modified vertex data
    modified_vertices['x'] = vertex_data['x']
    modified_vertices['y'] = vertex_data['y']
    modified_vertices['z'] = vertex_data['z']
    modified_vertices['red'] = vertex_data['red']
    modified_vertices['green'] = vertex_data['green']
    modified_vertices['blue'] = vertex_data['blue']
    modified_vertices['alpha'] = vertex_data['alpha']  # Make sure to include alpha
    
    # Create a new PlyData object with modified vertex data
    modified_elements = [PlyElement.describe(modified_vertices, 'vertex')]
    
    # Check if there is face data and include it
    if 'face' in ply_data:
        face_data = ply_data['face']
        modified_elements.append(PlyElement.describe(face_data.data, 'face'))
    
    modified_ply_data = PlyData(modified_elements, text=False)

    # Write the modified PLY data to a new file
    new_file_path = file_path.replace('.ply', '_modified.ply')
    
    try:
        modified_ply_data.write(new_file_path)
        print(f"Modified PLY file saved as: {new_file_path}")
    except Exception as e:
        print(f"Error writing modified PLY file: {e}")

def bulk_replace_color_in_ply(directory, target_color, replacement_color, tolerance):
    # Iterate through all PLY files in the specified directory
    for filename in os.listdir(directory):
        if filename.endswith('.ply'):
            file_path = os.path.join(directory, filename)
            replace_color_in_ply(file_path, target_color, replacement_color, tolerance)

# Example usage
directory = 'C:/Users/User/Desktop/Cuptra/CupTray/CupTrayRobot/Code/UR3Tray/Testing/New folder'
target_color = (0.089*255, 0.708*255, 0.991*255)  # RGB color to replace
replacement_color = (223, 53, 53)  # New color to replace with
tolerance = 100  # Set tolerance for color matching

bulk_replace_color_in_ply(directory, target_color, replacement_color, tolerance)
