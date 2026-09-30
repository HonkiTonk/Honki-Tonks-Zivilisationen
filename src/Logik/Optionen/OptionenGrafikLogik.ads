private with Ada.Strings.Wide_Wide_Unbounded;

private with Sf.System.Vector2;

private with SystemRecordsHTSEB;

with RueckgabeDatentypen;

package OptionenGrafikLogik is
   pragma Elaborate_Body;

   function OptionenGrafik
     return RueckgabeDatentypen.Rückgabe_Werte_Enum;

private
   use Ada.Strings.Wide_Wide_Unbounded;

   EinstellungenSchreiben : Boolean;
   EinstellungenGeändert : Boolean;

   Auflösung : constant RueckgabeDatentypen.Auswahl_Enum := RueckgabeDatentypen.Auswahl_Enum'First;
   Vollbild : constant RueckgabeDatentypen.Auswahl_Enum := RueckgabeDatentypen.Auswahl_Enum'Succ (Auflösung);
   Rahmenlos : constant RueckgabeDatentypen.Auswahl_Enum := RueckgabeDatentypen.Auswahl_Enum'Succ (Vollbild);
   VSync : constant RueckgabeDatentypen.Auswahl_Enum := RueckgabeDatentypen.Auswahl_Enum'Succ (Rahmenlos);
   Bildrate : constant RueckgabeDatentypen.Auswahl_Enum := RueckgabeDatentypen.Auswahl_Enum'Succ (VSync);
   Ebenensichtbarkeit : constant RueckgabeDatentypen.Auswahl_Enum := RueckgabeDatentypen.Auswahl_Enum'Succ (Bildrate);
   Bildratensichtbarkeit : constant RueckgabeDatentypen.Auswahl_Enum := RueckgabeDatentypen.Auswahl_Enum'Succ (Ebenensichtbarkeit);
   Texturenwechsel : constant RueckgabeDatentypen.Auswahl_Enum := RueckgabeDatentypen.Auswahl_Enum'Succ (Bildratensichtbarkeit);

   AuswahlWert : RueckgabeDatentypen.Rückgabe_Werte_Enum;

   GewählteTexturen : Unbounded_Wide_Wide_String;

   EingabeAuflösung : SystemRecordsHTSEB.ZahlenEingabeRecord;
   EingabeBildrate : SystemRecordsHTSEB.ZahlenEingabeRecord;

   NeueAuflösung : Sf.System.Vector2.sfVector2u;

   procedure VollbildFenster;
   procedure FensterRahmenlos;
   procedure Fenstermodus;



   function AuflösungÄndern
     return Boolean;

   function BildrateÄndern
     return Boolean;

   function TexturenWechseln
     return Boolean;

end OptionenGrafikLogik;
