# This file has extensoion .jl only for the purposes of syntax highlighting; it should not
#   be run

dsge.jl/
  src/
    DSGE.jl
      module DSGE
        export M990
        include("init/DistributionsExt.jl")
        include("init/FinancialFrictionsFunctions.jl")
        include("AbstractModel.jl")
        include("solve/Gensys.jl")
        include("solve/solve.jl")
        include("estimate/Kalman.jl")
        include("models/M990.jl")
      end
    AbstractModel.jl
      module AbstractModel
        export Param, toreal, tomodel, Parameters, logprior, ModelInds, makedict, Model
        include("abstractmodel/param.jl")
        include("abstractmodel/parameters.jl")
        include("abstractmodel/modelinds.jl")
        include("abstractmodel/model.jl")
      end
    abstractmodel/
      param.jl
        using Distributions: Distribution
        import Base: convert, promote_rule, log, exp
        using ..DistributionsExt: PointMass
        type Param
        function toreal
        function tomodel
      parameters.jl
        import Base: start, next, done
        using Distributions: logpdf
        abstract Parameters
        function logprior
      modelinds.jl
        type ModelInds
        function makedict
      model.jl
        type Model
    models/
      M990.jl
        module M990
          using ..AbstractModel
          import ..AbstractModel: Model
          export Parameters990, ModelInds, Model
          include("m990/spec.jl")
          include("m990/parameters.jl")
          include("m990/modelinds.jl")
          include("m990/eqcond.jl")
          include("m990/measurement.jl")
          function AbstractModel.Model
        end
      m990/
        spec.jl
          function spec_vars
        parameters.jl
          using Distributions: Normal, quantile
          using Roots: fzero
          using ..DistributionsExt: Beta, Gamma, InverseGamma
          using ..FinancialFrictionsFunctions
          type Parameters990 <: Parameters
          function steadystate!
        modelinds.jl
          using ..AbstractModel
          import ..AbstractModel: ModelInds
          function AbstractModel.ModelInds
        eqcond.jl
          using ..AbstractModel
          function eqcond
        measurement.jl
          using ..AbstractModel
          function measurement
    init/
      DistributionsExt.jl
        module DistributionsExt
          using Distributions
          import Distributions: pdf, mean, std
          type PointMass <: Distribution{Univariate, Continuous}
          function Beta
          function Gamma
          function InverseGamma
        end
      FinancialFrictionsFunctions.jl
        module FinancialFrictionsFunctions
          using Distributions
          export ζ_spb_fn, ...
          function ζ_spb_fn
          ...
        end
    solve/
      Gensys.jl
        module Gensys
          include("ordered_qz.jl")
          export gensys, ordschur
          function new_div
          function gensys
          function gensys!
          function qzdiv
          function qzdiv!
          function qzswitch!
        end
      Gensys_versions.jl
        function gensys_qzdiv
        function gensys_ordschur
      ordered_qz.jl
      solve.jl
        using ..AbstractModel, ..Gensys
        function solve
        function augment_states
    estimate/
      Kalman.jl
        module Kalman
          export kalcvf2NaN, kalsmth_k93
          function kalcvf2NaN
          function kalsmth_k93
          function distsmth_k93
        end
    forecast/
  docs/
    fileorg.jl # You are here
    ProposedOrganization.md
    DSGE_Model_Documentation.pdf
    supersticky1214.pdf
  test/
    test_readcsv_complex.csv
    util.jl
      using Base.Test
      function minusnan
      function test_matrix_eq
      function readcsv_complex
      function test_util
      function test_test_matrix_eq
      function test_readcsv_complex
    test_AbstractModel.jl
      using Base.Test
      using Distributions
      using DSGE: DistributionsExt, AbstractModel
      function test_all
      function test_param
      function test_parameters
      function test_modelinds
    models/
      test_M990.jl
        using Base.Test, Distributions
        using DSGE: DistributionsExt, AbstractModel, M990
        include("../util.jl")
        function test_all
        function test_parameters
        function test_modelinds
        function test_eqcond
        function test_measurement
      m990/
        parameters/
          para.csv
          ...
        eqcond/
          Γ0.csv
          ...
        gensys/
          Γ1.csv
          ...
    solve/
      test_Gensys.jl
        using Base: Test, LinAlg
        using MATLAB
        using DSGE: Gensys
        include("../util.jl")
        include("../../src/solve/Gensys_versions.jl")
      test_ordered_qz.jl
        using Base.Test, Compat
        import Base.Linalg: BlasComplex, BlasFloat, BlasReal, QRPivoted
        include("../../src/solve/ordered_qz.jl")
      gensys/
        gensys_args.mat
        gensys_variables.mat
        make_gensys_args.m
        test_Gensys.m
      test_solve.mat
      test_solve.jl
        using Base: Test
        using MATLAB
        using DSGE: M990
        include("../util.jl")
    estimate/
      test_Kalman.jl
        using Base.Test
        using MATLAB
        using DSGE.Kalman
        include("../util.jl")
      kalcvf2NaN/
        kalcvf2NaN_args.mat
        kalcvf2NaN_out7.mat
        kalcvf2NaN_out9.mat
        test_kalcvf2NaN.m
      test_likelihood.mat
      test_likelihood.jl
        using Base: Test
        using MATLAB
        using DSGE
        using DSGE: M990
        include("../util.jl")
  README.md