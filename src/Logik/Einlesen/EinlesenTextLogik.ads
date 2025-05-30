private with Ada.Wide_Wide_Text_IO;
private with Ada.Directories;
private with Ada.Strings.Wide_Wide_Unbounded;

private with TextKonstantenHTSEB;
private with UmwandlungssystemHTSEB;

private with Menuetexte;
private with Spieltexte;
private with Sequenzentexte;
private with Kartentexte;
private with Speziestexte;
private with SpeziesDatentypen;

package EinlesenTextLogik is
   pragma Elaborate_Body;
   
   procedure EinlesenDateien
     (EinsprachigExtern : in Boolean);
   
private
   use Ada.Wide_Wide_Text_IO;
   use Ada.Directories;
   use Ada.Strings.Wide_Wide_Unbounded;
   
   AnzahlTextdateien : constant Positive := 23;
   
   -- Menüs
   -- Überall Menü anhängen um eine bessere Abgrenzung von ähnlichen Textdateinamen zu haben? äöü
   -- Das auch bei den andere Konstanten tun? äöü
   Hauptmenü : constant Positive := Menuetexte.Hauptmenü'Last;
   Spielmenü : constant Positive := Hauptmenü + Menuetexte.Spielmenü'Last;
   Optionsmenü : constant Positive := Spielmenü + Menuetexte.Optionsmenü'Last;
   Grafikmenü : constant Positive := Optionsmenü + Menuetexte.Grafikmenü'Last;
   Soundmenü : constant Positive := Grafikmenü + Menuetexte.Soundmenü'Last;
   Steuerungsmenü : constant Positive := Soundmenü + Menuetexte.Steuerungsmenü'Last;
   Sonstigesmenü : constant Positive := Steuerungsmenü + Menuetexte.Spieleinstellungsmenü'Last;
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
   
   -- Spieltexte
   Fragen : constant Positive := Spieltexte.Fragen'Last;
   Meldungen : constant Positive := Fragen + Spieltexte.Meldungen'Last;
   Würdigungen : constant Positive := Meldungen + Spieltexte.Würdigungen'Last;
   Zeug : constant Positive := Würdigungen + Spieltexte.Zeug'Last;
   Stadtbefehle : constant Positive := Zeug + Spieltexte.Stadtbefehle'Last;
   Ladezeiten : constant Positive := Stadtbefehle + Spieltexte.Ladezeiten'Last;
   Beschäftigungen : constant Positive := Ladezeiten + Spieltexte.Beschäftigungen'Last;
   -- Spieltexte
   
   -- Sequenzen
   Intro : constant Positive := Sequenzentexte.Intro'Last;
   Outro : constant Positive := Intro + Sequenzentexte.Outro'Last;
   -- Sequenzen
   
   -- Karte
   Basisgrund : constant Positive := Kartentexte.Basisgrund'Last;
   Zusatzgrund : constant Positive := Basisgrund + Kartentexte.Zusatzgrund'Last;
   Flüsse : constant Positive := Zusatzgrund + Kartentexte.Flüsse'Last;
   Ressourcen : constant Positive := Flüsse + Kartentexte.Ressourcen'Last;
   Feldeffekte : constant Positive := Ressourcen + Kartentexte.Feldeffekte'Last;
   Verbesserungen : constant Positive := Feldeffekte + Kartentexte.Verbesserungen'Last;
   Wege : constant Positive := Verbesserungen + Kartentexte.Wege'Last;
   -- Karte
   
   -- Spezies
   NameBeschreibung : constant Positive := Speziestexte.NameBeschreibungArray'Last (2);
   Städtenamen : constant Positive := NameBeschreibung + Speziestexte.StädtenamenArray'Length (2);
   Forschungen : constant Positive := Städtenamen + Speziestexte.ForschungenArray'Length (2) * Speziestexte.ForschungenArray'Last (3);
   Einheiten : constant Positive := Forschungen + Speziestexte.EinheitenArray'Length (2) * Speziestexte.EinheitenArray'Last (3);
   Gebäude : constant Positive := Einheiten + Speziestexte.GebäudeArray'Length (2) * Speziestexte.GebäudeArray'Last (3);
   -- Spezies
   
   
   EinzulesendeZeile : Positive;
   AktuelleZeile : Positive;
   EinzulesendeDateizeile : Positive;
   AktuelleDateizeile : Positive;
   ZeilenumwandlungForschungen : Positive;
   ZeilenumwandlungEinheiten : Positive;
   ZeilenumwandlungGebäude : Positive;
   
   ZeilenumwandlungsabzugForschungen : Natural;
   ZeilenumwandlungsabzugEinheiten : Natural;
   ZeilenumwandlungsabzugGebäude : Natural;
   
   DateiVerzeichnisse : File_Type;
   DateiText : File_Type;
   
   Suche : Search_Type;
   
   Verzeichnis : Directory_Entry_Type;
   
   Zwischenspeicher : Unbounded_Wide_Wide_String;
   Dateiname : Unbounded_Wide_Wide_String;
   GesamterPfad : Unbounded_Wide_Wide_String;
   
   type ErsetzungenEingelesenArray is array (1 .. 6) of Unbounded_Wide_Wide_String;
   ErsetzungenEingelesen : ErsetzungenEingelesenArray := (others => TextKonstantenHTSEB.FehlenderText);
   
   procedure Debugmenü;
   
   procedure Einlesen
     (VerzeichnisExtern : in Wide_Wide_String;
      EinsprachigExtern : in Boolean)
     with
   -- Den Contract später mal noch um die Länge des Sprachenordners und /0 erweitern. äöü
     Pre => (
               VerzeichnisExtern'Length > 0
            );
   
   procedure EinlesenAufteilen
     (WelcheDateiExtern : in Positive;
      DateipfadExtern : in Wide_Wide_String;
      EinsprachigExtern : in Boolean)
     with
       Pre => (
                 WelcheDateiExtern <= AnzahlTextdateien
               and
                 DateipfadExtern'Length > 0
              );
   
   procedure Ersetzungen
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean);
   
   procedure Menüs
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean);
   
   procedure AllgemeineTexte
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean);
   
   procedure Sequenzen
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean);
   
   procedure Karte
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean);
   
   procedure Spezies
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum);
   
   
      
   function TextErsetzen
     (TextExtern : in Unbounded_Wide_Wide_String)
      return Unbounded_Wide_Wide_String;
   
   function Einsprachig
     (EinsprachigExtern : in Boolean;
      EingelesenerTextExtern : in Unbounded_Wide_Wide_String;
      VorhandenerTextExtern : in Unbounded_Wide_Wide_String)
      return Unbounded_Wide_Wide_String;
   
   function ZahlAlsString is new UmwandlungssystemHTSEB.Zahlenstring (GanzeZahl => Positive);
   
end EinlesenTextLogik;
