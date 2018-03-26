function [S] = skeleton_laplacian(vertices, faces)
% extract curve skeleton from a point cloud or triangular mesh
% input point clud to normalized to [center, scale]
% update: 2010-8-19
% update: 2010-7-12
% create: 2009-4-26
% by: JJCAO, deepfish @ DUT
%
%% setting
path('toolbox',path);
options.USING_POINT_RING = GS.USING_POINT_RING;

%% Step 0: read file (point cloud & local feature size if possible), and
S.pts = vertices;
S.faces = faces;
S.npts = size(S.pts,1);
% S.pts = GS.normalize_cs(S.pts);
[S.bbox, S.diameter] = GS.compute_bbox(S.pts);

%% Step 1: build local 1-ring
% build neighborhood, knn?
tic
S.k_knn = GS.compute_k_knn(S.npts);
if options.USING_POINT_RING
    S.rings = compute_point_point_ring(S.pts, S.k_knn, []);
else    
    S.frings = compute_vertex_face_ring(S.faces);
    S.rings = compute_vertex_ring(S.faces, S.frings);
%     GS.one_ring_area(S.pts,S.faces,S.frings);
end
disp(sprintf('compute local 1-ring:'));
toc

%% Step 1: Contract point cloud by Laplacian
tic
[S.cpts, t, initWL, WC, sl] = contraction_by_mesh_laplacian(S, options);
disp(sprintf('Contraction:'));
toc
%% step 2: Point to curve �C by cluster ROSA2.0
tic
S.sample_radius = S.diameter*0.02;
S = rosa_lineextract(S,S.sample_radius, 1);
disp(sprintf('to curve:'));
toc