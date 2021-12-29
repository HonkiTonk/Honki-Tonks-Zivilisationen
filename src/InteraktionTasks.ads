pragma SPARK_Mode (On);

with SystemDatentypen;

package InteraktionTasks is
   
   -- Jeden Taskbereich in einen eigenen Bereich verschieben?
   -- Die Bereiche sind auch nur mäßig sinnvoll sortiert.
   -- Logiktask
   procedure FensterErzeugtÄndern;
   
   procedure AktuelleRasseÄndern
     (RasseExtern : in SystemDatentypen.Rassen_Enum);
   
   
   
   function FensterErzeugtAbrufen
     return Boolean;
   
   function AktuelleRasseAbrufen
     return SystemDatentypen.Rassen_Enum;
   -- Logiktask
   
   
   
   -- Grafiktask
   procedure ErzeugeFensterÄndern;
   procedure FensterVerändertÄndern;
   
   procedure EingabeÄndern
     (EingabeExtern : in SystemDatentypen.Welche_Eingabe_Enum);
   
   procedure AktuelleDarstellungÄndern
     (DarstellungExtern : in SystemDatentypen.Grafik_Aktuelle_Darstellung_Enum);
   
   
   
   function ErzeugeFensterAbrufen
     return Boolean;
   
   function FensterVerändertAbrufen
     return Boolean;
   
   function EingabeAbrufen
     return SystemDatentypen.Welche_Eingabe_Enum;
   
   function AktuelleDarstellungAbrufen
     return SystemDatentypen.Grafik_Aktuelle_Darstellung_Enum;
   -- Grafiktask
   
   
   
   -- Soundtask
   procedure AktuelleMusikÄndern
     (MusikExtern : in SystemDatentypen.Musik_Aktuelle_Auswahl_Enum);
   
   
   
   function AktuelleMusikAbfragen
     return SystemDatentypen.Musik_Aktuelle_Auswahl_Enum;
   -- Soundtask
   
private
   
   -- Logiktask
   FensterErzeugt : Boolean := False;
      
   AktuelleRasse : SystemDatentypen.Rassen_Enum := SystemDatentypen.Keine_Rasse;
   -- Logiktask
   
   
   
   -- Grafiktask
   ErzeugeFenster : Boolean := False;
   FensterVerändert : Boolean := False;
   
   Eingabe : SystemDatentypen.Welche_Eingabe_Enum := SystemDatentypen.Keine_Eingabe;
   
   AktuelleDarstellung : SystemDatentypen.Grafik_Aktuelle_Darstellung_Enum := SystemDatentypen.Grafik_SFML;
   -- Grafiktask
   
   
   
   -- Soundtask
   AktuelleMusik : SystemDatentypen.Musik_Aktuelle_Auswahl_Enum := SystemDatentypen.Musik_SFML;
   -- Soundtask

end InteraktionTasks;
