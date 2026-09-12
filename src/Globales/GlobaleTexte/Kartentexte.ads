with ArraysHTSEB;
with TextKonstantenHTSEB;

with KartenzusatzgrundDatentypen;
with KartenverbesserungDatentypen;
with KartenfluesseDatentypen;
with KartenressourcenDatentypen;
with KarteneffekteDatentypen;
with KartenbasisgrundDatentypen;
with KartenwegeDatentypen;

package Kartentexte is
   pragma Elaborate_Body;
   
   NameBeschreibungMultiplikator : constant Positive := 2;
   
   Basisgrund : ArraysHTSEB.AllgemeinesTextArray (1 .. NameBeschreibungMultiplikator * KartenbasisgrundDatentypen.Basisgrund_Enum'Pos (KartenbasisgrundDatentypen.Basisgrund_Enum'Last))
     := (others => TextKonstantenHTSEB.FehlenderText);
   Zusatzgrund : ArraysHTSEB.AllgemeinesTextArray (1 .. NameBeschreibungMultiplikator * KartenzusatzgrundDatentypen.Zusatzgrund_Enum'Pos (KartenzusatzgrundDatentypen.Zusatzgrund_Enum'Last))
     := (others => TextKonstantenHTSEB.FehlenderText);
   
   Flüsse : ArraysHTSEB.AllgemeinesTextArray (1 .. NameBeschreibungMultiplikator * KartenfluesseDatentypen.Fluss_Enum'Pos (KartenfluesseDatentypen.Fluss_Enum'Last))
     := (others => TextKonstantenHTSEB.FehlenderText);
   Ressourcen : ArraysHTSEB.AllgemeinesTextArray (1 .. NameBeschreibungMultiplikator * KartenressourcenDatentypen.Ressourcen_Enum'Pos (KartenressourcenDatentypen.Ressourcen_Enum'Last))
     := (others => TextKonstantenHTSEB.FehlenderText);
   Feldeffekte : ArraysHTSEB.AllgemeinesTextArray (1 .. NameBeschreibungMultiplikator * KarteneffekteDatentypen.Effekt_Kartenfeld_Vorhanden_Enum'Pos (KarteneffekteDatentypen.Effekt_Kartenfeld_Vorhanden_Enum'Last))
     := (others => TextKonstantenHTSEB.FehlenderText);
   
   Verbesserungen : ArraysHTSEB.AllgemeinesTextArray (1 .. NameBeschreibungMultiplikator * KartenverbesserungDatentypen.Verbesserung_Enum'Pos (KartenverbesserungDatentypen.Verbesserung_Enum'Last))
     := (others => TextKonstantenHTSEB.FehlenderText);
   Wege : ArraysHTSEB.AllgemeinesTextArray (1 .. NameBeschreibungMultiplikator * KartenwegeDatentypen.Weg_Enum'Pos (KartenwegeDatentypen.Weg_Enum'Last))
     := (others => TextKonstantenHTSEB.FehlenderText);

end Kartentexte;
