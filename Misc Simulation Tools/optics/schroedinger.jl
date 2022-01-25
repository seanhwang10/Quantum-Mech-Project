"""
    timeevolution.schroedinger(tspan, psi0, H; fout)

Integrate Schroedinger equation to evolve states or compute propagators.

# Arguments
* `tspan`: Vector specifying the points of time for which output should be displayed.
* `psi0`: Initial state vector (can be a bra or a ket) or initial propagator.
* `H`: Arbitrary operator specifying the Hamiltonian.
* `fout=nothing`: If given, this function `fout(t, psi)` is called every time
        an output should be displayed. ATTENTION: The state `psi` is neither
        normalized nor permanent! It is still in use by the ode solver and
        therefore must not be changed.
"""
function schroedinger(tspan, psi0::T, H::AbstractOperator{B,B};
                fout::Union{Function,Nothing}=nothing,
                kwargs...) where {B,T<:Union{AbstractOperator{B,B},StateVector{B}}}
    dschroedinger_(t, psi, dpsi) = dschroedinger!(dpsi, H, psi)
    x0 = psi0.data
    state = copy(psi0)
    dstate = copy(psi0)
    integrate(tspan, dschroedinger_, x0, state, dstate, fout; kwargs...)
end


"""
    timeevolution.schroedinger_dynamic(tspan, psi0, f; fout)

Integrate time-dependent Schroedinger equation to evolve states or compute propagators.

# Arguments
* `tspan`: Vector specifying the points of time for which output should be displayed.
* `psi0`: Initial state vector (can be a bra or a ket) or initial propagator.
* `f`: Function `f(t, psi) -> H` returning the time and or state dependent Hamiltonian.
* `fout=nothing`: If given, this function `fout(t, psi)` is called every time
        an output should be displayed. ATTENTION: The state `psi` is neither
        normalized nor permanent! It is still in use by the ode solver and
        therefore must not be changed.
"""
function schroedinger_dynamic(tspan, psi0, f;
                fout::Union{Function,Nothing}=nothing,
                kwargs...)
    dschroedinger_(t, psi, dpsi) = dschroedinger_dynamic!(dpsi, f, psi, t)
    x0 = psi0.data
    state = copy(psi0)
    dstate = copy(psi0)
    integrate(tspan, dschroedinger_, x0, state, dstate, fout; kwargs...)
end

"""
    recast!(x,y)

Write the data stored in `y` into `x`, where either `x` or `y` is a quantum
object such as a [`Ket`](@ref) or an [`Operator`](@ref), and the other one is
a vector or a matrix with a matching size.
"""
recast!(psi::StateVector{B,D},x::D) where {B, D} = (psi.data = x);
recast!(x::D,psi::StateVector{B,D}) where {B, D} = nothing

"""
    dschroedinger!(dpsi, H, psi)

Update the increment `dpsi` in-place according to a Schrödinger equation
as `-im*H*psi`.

See also: [`dschroedinger_dynamic!`](@ref)
"""
function dschroedinger!(dpsi, H, psi)
    QuantumOpticsBase.mul!(dpsi,H,psi,eltype(psi)(-im),zero(eltype(psi)))
    return dpsi
end

function dschroedinger!(dpsi, H, psi::Bra)
    QuantumOpticsBase.mul!(dpsi,psi,H,eltype(psi)(im),zero(eltype(psi)))
    return dpsi
end

"""
    dschroedinger_dynamic!(dpsi, f, psi, t)

Compute the Hamiltonian as `H=f(t, psi)` and update `dpsi` according to a
Schrödinger equation as `-im*H*psi`.

See also: [`dschroedinger!`](@ref)
"""
function dschroedinger_dynamic!(dpsi, f, psi, t)
    H = f(t, psi)
    dschroedinger!(dpsi, H, psi)
end


function check_schroedinger(psi, H)
    check_multiplicable(H, psi)
    check_samebases(H)
end

function check_schroedinger(psi::Bra, H)
    check_multiplicable(psi, H)
    check_samebases(H)
end
