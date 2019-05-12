function splane(z,p)

plot(real(z),imag(z),'o');
hold on;
plot(real(p),imag(p),'x');
axis("equal");

plot([0,0],ylim(),'--');
plot(xlim(),[0,0],'--');

end

