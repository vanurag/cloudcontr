function rings = compute_vertex_face_ring( faces )

% compute_vertex_face_ring - compute the faces adjacent to each vertex
%
%   rings = compute_vertex_face_ring(faces);
%   rings{i} is set of faces adjacent to vertex i
%
%   Copyright (c) 2007 Gabriel Peyr?

nfaces = size(faces,1);
nverts = max(faces(:));

rings{nverts} = [];

for i=1:nfaces
    for k=1:3
        rings{faces(i,k)}(end+1) = i;
    end
end

