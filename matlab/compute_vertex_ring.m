function vrings = compute_vertex_ring(faces, frings)

% compute_vertex_ring - compute the 1 ring of each vertex in a mesh.
%
%   vring{i} is the set of vertices that are adjacent
%   to vertex i.

nfaces = size(faces,1);
nverts = max(faces(:));

vrings{nverts} = [];

for i=1:nverts
    for j=frings{i}
        for k=1:3
            if (~ismember(faces(j,k),vrings{i})) && (i ~= faces(j,k))
                vrings{i}(end+1) = faces(j,k);
            end
        end
    end
end


