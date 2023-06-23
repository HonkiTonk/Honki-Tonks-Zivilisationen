with TextKonstanten;
with KartengrundDatentypen;
with KartenverbesserungDatentypen;
with KartenextraDatentypen;
with TextArrays;

package Kartentexte is
   pragma Elaborate_Body;
   
   NameBeschreibungMultiplikator : constant Positive := 2;
   
   Basisgrund : TextArrays.AllgemeinesTextArray (1 .. NameBeschreibungMultiplikator * KartengrundDatentypen.Basisgrund_Enum'Pos (KartengrundDatentypen.Basisgrund_Enum'Last)) := (others => TextKonstanten.FehlenderText);
   Zusatzgrund : TextArrays.AllgemeinesTextArray (1 .. NameBeschreibungMultiplikator * KartengrundDatentypen.Zusatzgrund_Enum'Pos (KartengrundDatentypen.Zusatzgrund_Enum'Last)) := (others => TextKonstanten.FehlenderText);
   Kartenflüsse : TextArrays.AllgemeinesTextArray (1 .. NameBeschreibungMultiplikator * KartenextraDatentypen.Fluss_Enum'Pos (KartenextraDatentypen.Fluss_Enum'Last)) := (others => TextKonstanten.FehlenderText);
   Kartenressourcen : TextArrays.AllgemeinesTextArray (1 .. NameBeschreibungMultiplikator * KartenextraDatentypen.Ressourcen_Enum'Pos (KartenextraDatentypen.Ressourcen_Enum'Last))
     := (others => TextKonstanten.FehlenderText);
   Feldeffekte : TextArrays.AllgemeinesTextArray (1 .. NameBeschreibungMultiplikator * KartenextraDatentypen.Effekt_Kartenfeld_Vorhanden_Enum'Pos (KartenextraDatentypen.Effekt_Kartenfeld_Vorhanden_Enum'Last))
     := (others => TextKonstanten.FehlenderText);
   
   Verbesserungen : TextArrays.AllgemeinesTextArray (1 .. NameBeschreibungMultiplikator * KartenverbesserungDatentypen.Verbesserung_Enum'Pos (KartenverbesserungDatentypen.Verbesserung_Enum'Last))
     := (others => TextKonstanten.FehlenderText);
   Wege : TextArrays.AllgemeinesTextArray (1 .. NameBeschreibungMultiplikator * KartenverbesserungDatentypen.Weg_Enum'Pos (KartenverbesserungDatentypen.Weg_Enum'Last)) := (others => TextKonstanten.FehlenderText);

end Kartentexte;
