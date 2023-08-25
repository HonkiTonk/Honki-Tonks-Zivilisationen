with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Ada.Directories; use Ada.Directories;
with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

private with Menuetexte;
private with TextKonstanten;
private with Meldungstexte;

private with UmwandlungenAdaEigenes;

package EinlesenTextLogik is
   pragma Elaborate_Body;
   
   procedure EinlesenDateien
     (EinsprachigExtern : in Boolean);
   
private
   
   AnzahlTextdateien : constant Positive := 18;
   
   -- Menüs
   -- Überall Menü anhängen um eine bessere Abgrenzung von ähnlichen Textdateinamen zu haben? äöü
   Hauptmenü : constant Positive := Menuetexte.Hauptmenü'Last;
   Spielmenü : constant Positive := Hauptmenü + Menuetexte.Spielmenü'Last;
   Optionsmenü : constant Positive := Spielmenü + Menuetexte.Optionsmenü'Last;
   Grafikmenü : constant Positive := Optionsmenü + Menuetexte.Grafikmenü'Last;
   Soundmenü : constant Positive := Grafikmenü + Menuetexte.Soundmenü'Last;
   Steuerungsmenü : constant Positive := Soundmenü + Menuetexte.Steuerungsmenü'Last;
   Sonstigesmenü : constant Positive := Steuerungsmenü + Menuetexte.Sonstigesmenü'Last;
   Kartengröße : constant Positive := Sonstigesmenü + Menuetexte.Kartengröße'Last;
   Kartenart : constant Positive := Kartengröße + Menuetexte.Kartenart'Last;
   Kartentemperatur : constant Positive := Kartenart + Menuetexte.Kartentemperatur'Last;
   Speziesauswahl : constant Positive := Kartentemperatur + Menuetexte.Speziesauswahl'Last;
   Schwierigkeitsgrad : constant Positive := Speziesauswahl + Menuetexte.Schwierigkeitsgrad'Last;
   Kartenform : constant Positive := Schwierigkeitsgrad + Menuetexte.Kartenform'Last;
   Ressourcenmenge : constant Positive := Kartenform + Menuetexte.Ressourcenmenge'Last;
   Diplomatiemenü : constant Positive := Ressourcenmenge + Menuetexte.Diplomatiemenü'Last;
   Einstellungsmenü : constant Positive := Diplomatiemenü + Menuetexte.Einstellungsmenü'Last;
   Kartenpole : constant Positive := Einstellungsmenü + Menuetexte.Kartenpole'Last;
   Spielstandmenü : constant Positive := Kartenpole + Menuetexte.Spielstandmenü'Last;
   Editorenmenü : constant Positive := Spielstandmenü + Menuetexte.Editorenmenü'Last;
   Handelsmenü : constant Positive := Editorenmenü + Menuetexte.Handelsmenü'Last;
   -- Menüs
   
   -- Meldungen
   Fragen : constant Positive := Meldungstexte.Frage'Last;
   Meldung : constant Positive := Fragen + Meldungstexte.Meldung'Last;
   Würdigungen : constant Positive := Meldung + Meldungstexte.Würdigung'Last;
   Zeug : constant Positive := Würdigungen + Meldungstexte.Zeug'Last;
   -- Meldungen
   
   
   EinzulesendeZeile : Positive;
   AktuelleZeile : Positive;
      
   DateiVerzeichnisse : File_Type;
   DateiText : File_Type;
   
   Suche : Search_Type;
   
   Verzeichnis : Directory_Entry_Type;
   
   Zwischenspeicher : Unbounded_Wide_Wide_String;
   
   type ErsetzungenEingelesenArray is array (1 .. 6) of Unbounded_Wide_Wide_String;
   ErsetzungenEingelesen : ErsetzungenEingelesenArray := (others => TextKonstanten.FehlenderText);
   
   procedure Einlesen
     (VerzeichnisExtern : in Wide_Wide_String;
      EinsprachigExtern : in Boolean)
     with
   -- Den Contracts später mal noch um die Länge des Sprachenordners und /0 erweitern. äöü
     Pre => (
               VerzeichnisExtern'Length > 0
            );
   
   procedure EinlesenAufteilen
     (WelcheDateiExtern : in Positive;
      VerzeichnisExtern : in Wide_Wide_String;
      EinsprachigExtern : in Boolean)
     with
       Pre => (
                 WelcheDateiExtern <= AnzahlTextdateien
               and
                 VerzeichnisExtern'Length > 0
              );
   
   procedure Ersetzungen
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean);
   
   procedure Menüs
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean);
   
   procedure Meldungen
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean);
   
   procedure Basisgrund
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean);
   
   procedure Verbesserungen
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean);
   
   procedure Beschäftigungen
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean);
   
   procedure DiplomatieKI
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean);
   
   procedure DiplomatieStatus
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean);
   
   procedure Angebot
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean);
   
   procedure Ladezeit
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean);
   
   procedure Wege
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean);
   
   procedure Kartenflüsse
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean);
   
   procedure Kartenressourcen
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean);
   
   procedure Stadtbefehle
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean);
   
   procedure Intro
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean);
   
   procedure Outro
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean);
   
   procedure Zusatzgrund
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean);
   
   procedure Feldeffekte
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean);
   
   
      
   function TextErsetzen
     (TextExtern : in Unbounded_Wide_Wide_String)
      return Unbounded_Wide_Wide_String;
   
   function Einsprachig
     (EinsprachigExtern : in Boolean;
      EingelesenerTextExtern : in Unbounded_Wide_Wide_String;
      VorhandenerTextExtern : in Unbounded_Wide_Wide_String)
      return Unbounded_Wide_Wide_String;
   
   function ZahlAlsString is new UmwandlungenAdaEigenes.ZahlAlsString (GanzeZahl => Positive);
   
end EinlesenTextLogik;
