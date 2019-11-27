clear
figure

for i=1:13
    f = find_motif34(i,3);
    G = digraph(f(:,:,1));
    subplot(1,13,i);
    plot(G, 'MarkerSize', 10, 'ArrowSize', 12, 'NodeFontSize', 15, 'LineWidth', 2);
    axis square
end