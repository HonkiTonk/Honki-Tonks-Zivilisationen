with ArraysHTSEB;

with TextKonstanten;
with KartengrundDatentypen;
with KartenverbesserungDatentypen;
with KartenextraDatentypen;

package Kartentexte is
   pragma Elaborate_Body;
   
   NameBeschreibungMultiplikator : constant Positive := 2;
   
   Basisgrund : ArraysHTSEB.AllgemeinesTextArray (1 .. NameBeschreibungMultiplikator * KartengrundDatentypen.Basisgrund_Enum'Pos (KartengrundDatentypen.Basisgrund_Enum'Last)) := (others => TextKonstanten.FehlenderText);
   Zusatzgrund : ArraysHTSEB.AllgemeinesTextArray (1 .. NameBeschreibungMultiplikator * KartengrundDatentypen.Zusatzgrund_Enum'Pos (KartengrundDatentypen.Zusatzgrund_Enum'Last)) := (others => TextKonstanten.FehlenderText);
   
   Flüsse : ArraysHTSEB.AllgemeinesTextArray (1 .. NameBeschreibungMultiplikator * KartenextraDatentypen.Fluss_Enum'Pos (KartenextraDatentypen.Fluss_Enum'Last)) := (others => TextKonstanten.FehlenderText);
   Ressourcen : ArraysHTSEB.AllgemeinesTextArray (1 .. NameBeschreibungMultiplikator * KartenextraDatentypen.Ressourcen_Enum'Pos (KartenextraDatentypen.Ressourcen_Enum'Last)) := (others => TextKonstanten.FehlenderText);
   Feldeffekte : ArraysHTSEB.AllgemeinesTextArray (1 .. NameBeschreibungMultiplikator * KartenextraDatentypen.Effekt_Kartenfeld_Vorhanden_Enum'Pos (KartenextraDatentypen.Effekt_Kartenfeld_Vorhanden_Enum'Last))
     := (others => TextKonstanten.FehlenderText);
   
   Verbesserungen : ArraysHTSEB.AllgemeinesTextArray (1 .. NameBeschreibungMultiplikator * KartenverbesserungDatentypen.Verbesserung_Enum'Pos (KartenverbesserungDatentypen.Verbesserung_Enum'Last))
     := (others => TextKonstanten.FehlenderText);
   Wege : ArraysHTSEB.AllgemeinesTextArray (1 .. NameBeschreibungMultiplikator * KartenverbesserungDatentypen.Weg_Enum'Pos (KartenverbesserungDatentypen.Weg_Enum'Last)) := (others => TextKonstanten.FehlenderText);

end Kartentexte;
