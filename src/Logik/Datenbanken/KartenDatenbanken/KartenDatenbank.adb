pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SchreibenDatenbankenLogik;

with KartengrundHimmel;
with KartengrundKern;
with KartengrundOberflaeche;
with KartengrundSonstiges;
with KartengrundUnterflaeche;
with KartengrundWeltall;
with KartengrundFluss;
with KartengrundRessourcen;

package body KartenDatenbank is
   
   procedure StandardKartengrundDatenbankLaden
   is begin
      
      KartenfelderSchleife:
      for KartenfelderSchleifenwert in KartengrundDatentypen.Kartengrund_Vorhanden_Enum'Range loop
         
         case
           KartenfelderSchleifenwert
         is
            when KartengrundDatentypen.Kartengrund_Weltraum_Enum'Range =>
               Kartengrundliste (KartenfelderSchleifenwert) := KartengrundWeltall.KartengrundlisteWeltall (KartenfelderSchleifenwert);
               
            when KartengrundDatentypen.Kartengrund_Himmel_Enum'Range =>
               Kartengrundliste (KartenfelderSchleifenwert) := KartengrundHimmel.KartengrundlisteHimmel (KartenfelderSchleifenwert);
               
            when KartengrundDatentypen.Kartengrund_Unterfläche_Enum'Range =>
               Kartengrundliste (KartenfelderSchleifenwert) := KartengrundUnterflaeche.KartengrundlisteUnterfläche (KartenfelderSchleifenwert);
               
            when KartengrundDatentypen.Kartengrund_Kernfläche_Enum'Range =>
               Kartengrundliste (KartenfelderSchleifenwert) := KartengrundKern.KartengrundlisteKern (KartenfelderSchleifenwert);
               
            when KartengrundDatentypen.Kartengrund_Sonstiges_Enum'Range =>
               Kartengrundliste (KartenfelderSchleifenwert) := KartengrundSonstiges.KartengrundlisteSonstiges (KartenfelderSchleifenwert);
               
            when KartengrundDatentypen.Kartengrund_Oberfläche_Enum'Range =>
               Kartengrundliste (KartenfelderSchleifenwert) := KartengrundOberflaeche.KartengrundlisteOberfläche (KartenfelderSchleifenwert);
         end case;
         
      end loop KartenfelderSchleife;
      
   end StandardKartengrundDatenbankLaden;
   
   

   procedure StandardKartenflussDatenbankLaden
   is begin
      
      KartenflussSchleife:
      for KartenflussSchleifenwert in KartengrundDatentypen.Kartenfluss_Vorhanden_Enum'Range loop
         
         case
           KartenflussSchleifenwert
         is
            when KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Range =>
               Kartenflussliste (KartenflussSchleifenwert) := KartengrundFluss.KartenflusslisteOberfläche (KartenflussSchleifenwert);
               
            when KartengrundDatentypen.Kartenfluss_Unterfläche_Enum'Range =>
               Kartenflussliste (KartenflussSchleifenwert) := KartengrundFluss.KartenflusslisteUnterfläche (KartenflussSchleifenwert);
               
            when KartengrundDatentypen.Kartenfluss_Kern_Enum'Range =>
               Kartenflussliste (KartenflussSchleifenwert) := KartengrundFluss.KartenflusslisteKern (KartenflussSchleifenwert);
         end case;
         
      end loop KartenflussSchleife;
      
   end StandardKartenflussDatenbankLaden;
   
   

   procedure StandardKartenressourcenDatenbankLaden
   is begin
      
      KartenressourcenSchleife:
      for KartenressourcenSchleifenwert in KartengrundDatentypen.Kartenressourcen_Vorhanden_Enum'Range loop
         
         case
           KartenressourcenSchleifenwert
         is
            when KartengrundDatentypen.Kartenressourcen_Oberfläche_Land_Enum'Range =>
               Kartenressourcenliste (KartenressourcenSchleifenwert) := KartengrundRessourcen.KartenressourcenlisteLand (KartenressourcenSchleifenwert);
               
            when KartengrundDatentypen.Kartenressourcen_Oberfläche_Wasser_Enum'Range =>
               Kartenressourcenliste (KartenressourcenSchleifenwert) := KartengrundRessourcen.KartenressourcenlisteWasser (KartenressourcenSchleifenwert);
         end case;
         
      end loop KartenressourcenSchleife;
      
   end StandardKartenressourcenDatenbankLaden;
   
   

   procedure KartengrundDatenbankSpeichern
   is begin
      
      SchreibenDatenbankenLogik.SchreibenKartenDatenbanken;
      
   end KartengrundDatenbankSpeichern;

end KartenDatenbank;
