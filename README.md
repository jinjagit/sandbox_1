# Sandbox_1
Starting point: [FaceWithHiddenMargin repo](https://github.com/jinjagit/face_with_margin)  
  
## Aims
Use this sandbox to discover / understand some basic techniques / concepts:  
  
Q: Do meshes, etc. get drawn in parallel?  
  
A: Apparently not, at least not the 6 `generate_mesh` instances that run here. Not a problem, necessarily, but good to know.  

Indeed, printing start end times for each iteration of loop proves this is sequential (expected, since using a loop!):
``` 
...
64 pressed (via Planet class)
start: 50915
end: 50974
start: 50974
end: 51022
start: 51022
end: 51067
start: 51067
end: 51112
start: 51112
end: 51157
start: 51157
end: 51201
```

My best guess at this point is that it could be better to run the calculations needed to create the final mesh arrays, triangle arrays, textures, etc. in parallel, using Rust (especially when high n of array elements, as with, say, the pixels on a high-res texture), and then render them in series (possibly avoids some engine weirdness if trying to render 2 or more at once, and probably not a significant performance issue, whereas the calculations will be).  
  
- [x] How to get (toggle-able) stats output (n verts, fps, etc) -> use for benchmarking

The `RENDER_VERTICES_IN_FRAME` stat seems to give the total number of indices used for triangles, and for both sides of triangles (? even if single-sided material used), not the number of vertices I use to create the underlying mesh. Not a problem, since I can calculate the number of vertices anyway.

Benchmarks (MacBook Pro) to Re-render all 6 face meshes of sphere:
```
resolution   seconds calculating vs reading   factor
 32            0.077
 64            0.301
128            2.51
256           29.85
```

- [x] How to get & handle input from UI (basics understood and tested)
- [x] Organize files in folders
- [x] How to write to file
- [x] How to destroy/recreate meshes
- [ ] How to read data from files and use to generate meshes
- [ ] How to integrate / use Rust


### Notes:

Currently using these normals for each cube face:

Name   (x, y, z)

Up     (0, 1, 0)
Down   (0, -1, 0)
Left   (-1, 0, 0)
Right  (1, 0, 0)
Back   (0, 0, -1)
Front  (0, 0, 1)


How to name face mesh data files / functions:

face_32_up

Each file returns:
All necessary mesh arrays
num_vertices

Return as dictionary: `my_dict = {"First Array": [1, 2, 3, 4]}`

## Developing mesh data files and reading thereof:

- [ ] How to write and read an array of Vector3s
- [ ] How to write and read all 6 sets of mesh arrays to one file (class)
- [ ] How to draw meshes from set of data
- [ ] How to select specific resolution for a set via UI (and benchmark)

