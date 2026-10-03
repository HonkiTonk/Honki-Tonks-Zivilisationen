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

   Spielmenü : constant RueckgabeDatentypen.Rückgabe_Werte_Enum := RueckgabeDatentypen.Start_Weiter_Standard_Enum;
   Kartenebene : constant RueckgabeDatentypen.Auswahl_Enum := RueckgabeDatentypen.Auswahl_Enum'First;
   Kartengröße : constant RueckgabeDatentypen.Auswahl_Enum := RueckgabeDatentypen.Auswahl_Enum'Succ (Kartenebene);
   Kartenpole : constant RueckgabeDatentypen.Auswahl_Enum := RueckgabeDatentypen.Auswahl_Enum'Succ (Kartengröße);
   Kartenart : constant RueckgabeDatentypen.Auswahl_Enum := RueckgabeDatentypen.Auswahl_Enum'Succ (Kartenpole);
   Kartenform : constant RueckgabeDatentypen.Auswahl_Enum := RueckgabeDatentypen.Auswahl_Enum'Succ (Kartenart);
   Kartentemperatur : constant RueckgabeDatentypen.Auswahl_Enum := RueckgabeDatentypen.Auswahl_Enum'Succ (Kartenform);
   Kartenrohstoffe : constant RueckgabeDatentypen.Auswahl_Enum := RueckgabeDatentypen.Auswahl_Enum'Succ (Kartentemperatur);
   Spezies : constant RueckgabeDatentypen.Auswahl_Enum := RueckgabeDatentypen.Auswahl_Enum'Succ (Kartenrohstoffe);
   Schwierigkeitsgrad : constant RueckgabeDatentypen.Auswahl_Enum := RueckgabeDatentypen.Auswahl_Enum'Succ (Spezies);

   Auswahl : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   Rückgabewert : RueckgabeDatentypen.Rückgabe_Werte_Enum;

   Zwischenspeicher : RueckgabeDatentypen.Hauptmenü_Beenden_Enum;

   function AutomatischeEinstellungen
     return RueckgabeDatentypen.Rückgabe_Werte_Enum;

end SpieleinstellungenLogik;
