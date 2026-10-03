with RueckgabeDatentypen;

private with SpeziesDatentypen;

private with LeseSpeziesbelegung;

package SpielLogik is
   pragma Elaborate_Body;

   function Spiel
     return RueckgabeDatentypen.Hauptmenü_Beenden_Enum;

private
   use type SpeziesDatentypen.Spieler_Enum;

   -- Das hier immer identisch mit den Werten in SpielmenueLogik halten oder mal in GlobaleKonstanten auslagern. äöü
   Weiter : constant RueckgabeDatentypen.Auswahl_Enum := RueckgabeDatentypen.Auswahl_Enum'First;
   Speichern : constant RueckgabeDatentypen.Auswahl_Enum := RueckgabeDatentypen.Auswahl_Enum'Succ (Weiter);
   Laden : constant RueckgabeDatentypen.Auswahl_Enum := RueckgabeDatentypen.Auswahl_Enum'Succ (Speichern);
   Optionen : constant RueckgabeDatentypen.Auswahl_Enum := RueckgabeDatentypen.Auswahl_Enum'Succ (Laden);

   -- Das hier immer identisch mit den Werten in BefehlsauswahlLogik halten oder mal in GlobaleKonstanten auslagern. äöü
   Spielmenü : constant RueckgabeDatentypen.Auswahl_Enum := RueckgabeDatentypen.Auswahl_Enum'First;
   Rundenende : constant RueckgabeDatentypen.Auswahl_Enum := RueckgabeDatentypen.Auswahl_Enum'Succ (Spielmenü);

   SchleifeVerlassen : constant RueckgabeDatentypen.Rückgabe_Werte_Enum := RueckgabeDatentypen.Auswahl_Neunzehn_Enum;

   AktuellerBefehlSpieler : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   RückgabeSpezies : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   RückgabeWert : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   RückgabeSpielmenü : RueckgabeDatentypen.Rückgabe_Werte_Enum;
   RückgabeMenschAmZug : RueckgabeDatentypen.Rückgabe_Werte_Enum;

   procedure KISpieler
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.KI_Spieler_Enum
              );

   function SpeziesImSpiel
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum;

   function SpeziesDurchgehen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

   function MenschlicherSpieler
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
              );

   function MenschAmZug
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
              );

end SpielLogik;
