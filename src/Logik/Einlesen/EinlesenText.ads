pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

private with Ada.Wide_Wide_Text_IO;

private with GlobaleTexte;
private with ZahlenDatentypen;

package EinlesenText is
   
   procedure EinlesenDateien;
   
private
      
   AktuelleZeile : ZahlenDatentypen.EigenesPositive;
      
   TextdateienEinlesen : GlobaleTexte.TexteArray (1 .. 36);

   DateiTextEinlesen : Ada.Wide_Wide_Text_IO.File_Type;
   
   procedure EinlesenTexte;
   procedure Hauptmenü;
   procedure Spielmenü;
   procedure Optionsmenü;
   procedure Grafikmenü;
   procedure Soundmenü;
   procedure Steuerungmenü;
   procedure Sonstigesmenü;
   procedure Kartengröße;
   procedure Kartenart;
   procedure Kartentemperatur;
   procedure Rassenauswahl;
   procedure Schwierigkeitsgrad;
   procedure Kartenform;
   procedure Ressourcenmenge;
   procedure Kartenfelder;
   procedure Verbesserungen;
   procedure Beschäftigungen;
   procedure Debugmenü;
   procedure AllgemeineInformationen;
   procedure Würdigung;
   procedure Diplomatiemenü;
   procedure DiplomatieKI;
   procedure Endmeldungen;
   procedure Handelsmenü;
   procedure DiplomatieStatus;
   procedure Angebot;
   procedure Fehlermeldung;
   procedure Ladezeit;
   procedure Frage;
   procedure ZeugSachen;
   procedure Editoren;
   procedure Wege;
   procedure Kartenflüsse;
   procedure Kartenressourcen;
   procedure Einstellungen;
   procedure Kartenpole;
   
   procedure EinlesenAufteilen
     (WelcherDateiExtern : in Positive)
     with
       Pre => (
                 WelcherDateiExtern <= TextdateienEinlesen'Last
              );
   
end EinlesenText;
