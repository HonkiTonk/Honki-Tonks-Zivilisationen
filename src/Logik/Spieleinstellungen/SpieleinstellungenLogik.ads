with RueckgabeDatentypen;

package SpieleinstellungenLogik is
   pragma Elaborate_Body;

   function Spieleinstellungen
     (SchnellstartExtern : in Boolean)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum;

   function KarteVorhanden
     return Boolean;

private

   KarteErstellt : Boolean := False;

   Auswahl : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   Rückgabewert : RueckgabeDatentypen.Rückgabe_Werte_Enum;

   Zwischenspeicher : RueckgabeDatentypen.Hauptmenü_Beenden_Enum;

   function AutomatischeEinstellungen
     return RueckgabeDatentypen.Rückgabe_Werte_Enum;

end SpieleinstellungenLogik;
