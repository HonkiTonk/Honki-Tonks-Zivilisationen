private with Ada.Strings.Wide_Wide_Unbounded;

private with SystemRecordsHTSEB;

with RueckgabeDatentypen;

package OptionenSonstigesLogik is
   pragma Elaborate_Body;

   function Sonstiges
     return RueckgabeDatentypen.Rückgabe_Werte_Enum;

private
   use Ada.Strings.Wide_Wide_Unbounded;
   
   Erfolgreich : Boolean;
   
   Eingabe : Wide_Wide_Character;
   
   AuswahlWert : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   
   GewählteSprache : Unbounded_Wide_Wide_String;
   
   EingegebeneZahl : SystemRecordsHTSEB.ZahlenEingabeRecord;
   
   procedure AnzahlAutomatischerSpielstände;
   procedure RundenBisAutospeichern;
   procedure SpracheWechseln;
   procedure Dezimaltrennzeichen;

end OptionenSonstigesLogik;
