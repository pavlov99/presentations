\timing

SELECT signal, COUNT(*) FROM higgs GROUP BY signal;

SELECT MAX(lepton_eta) FROM higgs;

SELECT signal, AVG(lepton_phi) FROM higgs GROUP BY signal;
