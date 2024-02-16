function dX = get_dX(M, dM, B, dB)

dX = pinv(M)*(dB - dM*X - nlambda*linear(M*X - B) - ngamma*linear(M*X - B) + nlambda*linear(M*X - B));

end