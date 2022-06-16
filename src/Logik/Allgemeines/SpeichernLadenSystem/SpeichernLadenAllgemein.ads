pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with SystemRecords;

package SpeichernLadenAllgemein is

   ---------------------------- Prüfungen und Contracts einbauen ob der Spielstandname eine Länge von mindestens eins hat? Und auf ungültige Zeichen prüfen? Bestimmte Zeichen gehen ja nicht überall!
   function SpielstandNameErmitteln
     return SystemRecords.TextEingabeRecord;
   
   function SpielstandVorhanden
     (SpielstandnameExtern : in Unbounded_Wide_Wide_String)
      return Boolean;
   
private
   
   MaximaleZeichenlängeDateisystem : constant Positive := 256;
   
   SpielstandName : SystemRecords.TextEingabeRecord;

end SpeichernLadenAllgemein;
