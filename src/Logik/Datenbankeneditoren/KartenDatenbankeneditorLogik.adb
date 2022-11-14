with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;

with KartengrundDatentypen;
with GrafikDatentypen;
with TastenbelegungDatentypen;

with KartenDatenbank;

with MausauswahlEditorLogik;
with NachGrafiktask;
with TasteneingabeLogik;

package body KartenDatenbankeneditorLogik is
   
   procedure KartenDatenbankenEditor
   is begin
      
      NachGrafiktask.WelcherEditor := GrafikDatentypen.Kartengrund_Editor_Enum;
      NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Editoren_Enum;
      
      KartengrundSchleife:
      loop
         
         Feldauswahl := Kartenfeldauswahl;
         
         case
           Feldauswahl
         is
            when KartengrundDatentypen.Leer_Grund_Enum =>
               exit KartengrundSchleife;
               
            when others =>
               Feldeinstellungen (FeldExtern => Feldauswahl);
         end case;
           
      end loop KartengrundSchleife;
      
      KartenDatenbank.KartengrundDatenbankSpeichern;
      
   end KartenDatenbankenEditor;
   
   
   
   function Kartenfeldauswahl
     return KartengrundDatentypen.Kartengrund_Enum
   is begin
      
      AuswahlSchleife:
      loop
         
         case
           TasteneingabeLogik.VereinfachteEingabe
         is
            when TastenbelegungDatentypen.Auswählen_Enum =>
               return MausauswahlEditorLogik.Kartengrundeditor;
               
            when TastenbelegungDatentypen.Abwählen_Enum =>
               return KartengrundDatentypen.Leer_Grund_Enum;
               
            when others =>
               null;
         end case;
         
      end loop AuswahlSchleife;
      
   end Kartenfeldauswahl;
   
   
   
   -- Als Menü aufbauen und entsprechend nur die Auswahlmöglichkeiten als Text einbauen? äöü
   procedure Feldeinstellungen
     (FeldExtern : in KartengrundDatentypen.Kartengrund_Vorhanden_Enum)
   is begin
      
      Put_Line (FeldExtern'Wide_Wide_Image);
      
      EinstellungSchleife:
      loop
         
         exit EinstellungSchleife;
         
      end loop EinstellungSchleife;
      
      KartenDatenbank.KartengrundDatenbankSpeichern;
      
   end Feldeinstellungen;

end KartenDatenbankeneditorLogik;
