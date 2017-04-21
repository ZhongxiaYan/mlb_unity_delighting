import os

def scan_lighted_delighted(root_dir):
    '''
    returns:
        delighted_dirs: maps mesh (Mesh_000000) to directory of delighted data
            ('data/Rock/Mesh_000000/_Shared/')
        lighted_dirs: a list of (type, mesh, version, lighted_directory_path) tuples,
            i.e. (Rock, Mesh_000000, V_000014, 'data/Data_2017_03_31/Data/Rock/Mesh_000000/V_000014/')
    '''
    data_dir = root_dir + 'data/'
    delighted_dirs = {}
    lighted_dirs = []
    types = os.listdir(data_dir)
    for type in types:
        type_dir = data_dir + type + '/'
        meshes = [mesh for mesh in os.listdir(type_dir) if mesh.startswith('Mesh_')]
        for mesh in meshes:
            mesh_dir = type_dir + mesh + '/'
            delighted_dir = mesh_dir + '_Shared/'
            if mesh not in delighted_dirs:
                delighted_dirs[mesh] = delighted_dir
            delighted_dir = delighted_dirs[mesh]
            versions = [v for v in os.listdir(mesh_dir) if v.startswith('V_')]
            for version in versions:
                version_dir = mesh_dir + version + '/'
                lighted_dirs.append((type, mesh, version, version_dir))
    return delighted_dirs, lighted_dirs

def zero_rgb(im):
    '''
    takes in a r, g, b, a numpy array and zero out rgb if a = 0
    '''
    alpha = im[:, :, 3:] > 0
    return im * alpha

def downsample_image(image, factor):
    '''
    takes in a pillow image object, low pass, then downsample
    '''
    return image.resize((image.width // factor, image.height // factor), Image.ANTIALIAS)