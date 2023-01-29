with RueckgabeDatentypen;

package SpieleinstellungenLogik is
   pragma Elaborate_Body;

   function Spieleinstellungen
     (SchnellstartExtern : in Boolean)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum;

private

   Auswahl : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   Rückgabewert : RueckgabeDatentypen.Rückgabe_Werte_Enum;

   function AutomatischeEinstellungen
     return RueckgabeDatentypen.Rückgabe_Werte_Enum;

end SpieleinstellungenLogik;
