# Sandbox_1
Starting point: [FaceWithHiddenMargin repo](https://github.com/jinjagit/face_with_margin)  
  
## Aims
Use this sandbox to discover / understand some basic techniques / concepts:  
  
Q: Do meshes, etc. get drawn in parallel?  
  
A: Apparently not, at least not the 6 `generate_mesh` instances that run here. Not a problem, necessarily, but good to know.  
  
My best guess at this point is that it could be better to run the calculations needed to create the final mesh arrays, triangle arrays, textures, etc. in parallel, using Rust (especially when high n of array elements, as with, say, the pixels on a high-res texture), and then render them in series (possibly avoids some engine wierdness if trying to render 2 or more at once, and probably not a significant performance issue, whereas the calculations will be).  
  
- [x] How to get (toggle-able) stats output (n verts, fps, etc) -> use for benchmarking later

The `RENDER_VERTICES_IN_FRAME` stat seems to give the total number of indices used for triangles, and for both sides of triangles (? even if single-sided material used), not the number of vertices I use to create the underlying mesh. Not a problem, since I can calculate the number of vertices anyway.

Benchmarks to render all 6 face meshes of sphere:
```
resolution   seconds calculating vs reading   factor
 32            0.066
 64            0.300
128            2.777
256           35.903
```

- [x] How to get & handle input from UI (basics understood and tested)
- [x] Organize files in folders
- [ ] How to destroy/recreate meshes
- [ ] How to integrate / use Rust
