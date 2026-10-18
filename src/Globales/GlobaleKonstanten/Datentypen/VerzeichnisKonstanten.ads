with VerzeichnisKonstantenHTSEB;

package VerzeichnisKonstanten is
   pragma Pure;
   
   -- Die Datenbanken weiter aufteilen? Beispielsweise eine eigene Datenbank für Rohstoffe/Verarbeitung? äöü
   EinheitenDatenbank : constant Wide_Wide_String (1 .. 30) := VerzeichnisKonstantenHTSEB.Datenbankenordner & "EinheitenDatenbank";
   ForschungenDatenbank : constant Wide_Wide_String (1 .. 32) := VerzeichnisKonstantenHTSEB.Datenbankenordner & "ForschungenDatenbank";
   GebaeudeDatenbank : constant Wide_Wide_String (1 .. 29) := VerzeichnisKonstantenHTSEB.Datenbankenordner & "GebaeudeDatenbank";
   KartenDatenbank : constant Wide_Wide_String (1 .. 27) := VerzeichnisKonstantenHTSEB.Datenbankenordner & "KartenDatenbank";
   VerbesserungenDatenbank : constant Wide_Wide_String (1 .. 35) := VerzeichnisKonstantenHTSEB.Datenbankenordner & "VerbesserungenDatenbank";
   SpeziesDatenbank : constant Wide_Wide_String (1 .. 28) := VerzeichnisKonstantenHTSEB.Datenbankenordner & "SpeziesDatenbank";
   EffekteDatenbank : constant Wide_Wide_String (1 .. 28) := VerzeichnisKonstantenHTSEB.Datenbankenordner & "EffekteDatenbank";
   
   
   
   
   
   GrafikOhneStrich : constant String (1 .. 6) := "Grafik";
   GrafikEinfach : constant String (1 .. 7) := "Grafik/";
   
   MusikOhneStrich : constant String (1 .. 5) := "Musik";
   MusikEinfach : constant String (1 .. 6) := "Musik/";
   
   SoundOhneStrich : constant String (1 .. 5) := "Sound";
   SoundEinfach : constant String (1 .. 6) := "Sound/";
   
      
   
   Sprachen : constant String (1 .. 8) := "Sprachen";
   SprachenStrich : constant String (1 .. 9) := Sprachen & "/";
   FontOrdner : constant String (1 .. 15) := SprachenStrich & "Fonts/";
   SchriftartStandard : constant String (1 .. 16) := "wqy-microhei.ttc";
   FontsOrdner : constant String (1 .. 5) := "Fonts";
   Unifont : constant String (1 .. 11) := "unifont.otf";
         
end VerzeichnisKonstanten;
