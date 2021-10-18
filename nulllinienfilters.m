
function [verschobenesSignal] = nulllinienfilters(Originalsignal)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

% Schwelle und Fenstergröße festlegen
schwelle = 0.3;
ableitung = diff(Originalsignal);

% Verschiebungsvektor initialisieren
verschiebungsvek = zeros(size(Originalsignal));

% über das Signal laufen
for i=251:length(Originalsignal)-251
    % Summe und Anzahl mit Null initialsieren
    summe = 0;
    anzahl = 0;
    % Vektoren für die Fenster festlegen
    fensterOrSig = Originalsignal(i-250:i+250);
    fensterAbl = ableitung(i-250:i+250);
    % über das Fenster laufen
    for j=1:length(fensterOrSig)
        if(fensterAbl(j) <= schwelle && fensterAbl(j) >= -schwelle)
            summe = summe + fensterOrSig(j);
            anzahl = anzahl + 1;
        end
    end
    % Mittelwert aus Summe und Anz berechnen und im Rückgabevektor speichern
    mittelwert = summe/anzahl;
    verschiebungsvek(i) = mittelwert;
end

 verschiebungsvek(1:250) = verschiebungsvek(251); 
    verschiebungsvek(length(verschiebungsvek - 251):end) = verschiebungsvek(251); 

 % verschobenesSignal = Originalsignal - Verschiebung
    verschobenesSignal = Originalsignal - verschiebungsvek;
end

