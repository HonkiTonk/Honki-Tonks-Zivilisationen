with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with TextKonstanten;
with KartengrundDatentypen;
with KartenverbesserungDatentypen;
with KartenextraDatentypen;

package Kartentexte is
   pragma Elaborate_Body;
   
   NameBeschreibungMultiplikator : constant Positive := 2;

   type TexteArray is array (Positive range <>) of Unbounded_Wide_Wide_String;
   
   Basisgrund : TexteArray (1 .. NameBeschreibungMultiplikator * KartengrundDatentypen.Basisgrund_Enum'Pos (KartengrundDatentypen.Basisgrund_Enum'Last)) := (others => TextKonstanten.FehlenderText);
   Zusatzgrund : TexteArray (1 .. NameBeschreibungMultiplikator * KartengrundDatentypen.Zusatzgrund_Enum'Pos (KartengrundDatentypen.Zusatzgrund_Enum'Last)) := (others => TextKonstanten.FehlenderText);
   Kartenflüsse : TexteArray (1 .. NameBeschreibungMultiplikator * KartenextraDatentypen.Fluss_Enum'Pos (KartenextraDatentypen.Fluss_Enum'Last)) := (others => TextKonstanten.FehlenderText);
   Kartenressourcen : TexteArray (1 .. NameBeschreibungMultiplikator * KartenextraDatentypen.Ressourcen_Enum'Pos (KartenextraDatentypen.Ressourcen_Enum'Last)) := (others => TextKonstanten.FehlenderText);
   Feldeffekte : TexteArray (1 .. NameBeschreibungMultiplikator * KartengrundDatentypen.Effekt_Kartenfeld_Enum'Pos (KartengrundDatentypen.Effekt_Kartenfeld_Enum'Last)) := (others => TextKonstanten.FehlenderText);
   
   Verbesserungen : TexteArray (1 .. NameBeschreibungMultiplikator * KartenverbesserungDatentypen.Verbesserung_Enum'Pos (KartenverbesserungDatentypen.Verbesserung_Enum'Last))
     := (others => TextKonstanten.FehlenderText);
   Wege : TexteArray (1 .. NameBeschreibungMultiplikator * KartenverbesserungDatentypen.Weg_Enum'Pos (KartenverbesserungDatentypen.Weg_Enum'Last)) := (others => TextKonstanten.FehlenderText);

end Kartentexte;
