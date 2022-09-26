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
            when KartengrundWeltall.KartengrundlisteWeltallArray'Range =>
               Kartengrundliste (KartenfelderSchleifenwert) := KartengrundWeltall.KartengrundlisteWeltall (KartenfelderSchleifenwert);
               
            when KartengrundHimmel.KartengrundlisteHimmelArray'Range =>
               Kartengrundliste (KartenfelderSchleifenwert) := KartengrundHimmel.KartengrundlisteHimmel (KartenfelderSchleifenwert);
               
            when KartengrundUnterflaeche.KartengrundlisteUnterflächeArray'Range =>
               Kartengrundliste (KartenfelderSchleifenwert) := KartengrundUnterflaeche.KartengrundlisteUnterfläche (KartenfelderSchleifenwert);
               
            when KartengrundKern.KartengrundlisteKernArray'Range =>
               Kartengrundliste (KartenfelderSchleifenwert) := KartengrundKern.KartengrundlisteKern (KartenfelderSchleifenwert);
               
            when KartengrundSonstiges.KartengrundlisteSonstigesArray'Range =>
               Kartengrundliste (KartenfelderSchleifenwert) := KartengrundSonstiges.KartengrundlisteSonstiges (KartenfelderSchleifenwert);
               
            when KartengrundOberflaeche.KartengrundlisteOberflächeArray'Range =>
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
            when KartengrundFluss.KartenflusslisteOberflächeArray'Range =>
               Kartenflussliste (KartenflussSchleifenwert) := KartengrundFluss.KartenflusslisteOberfläche (KartenflussSchleifenwert);
               
            when KartengrundFluss.KartenflusslisteUnterflächeArray'Range =>
               Kartenflussliste (KartenflussSchleifenwert) := KartengrundFluss.KartenflusslisteUnterfläche (KartenflussSchleifenwert);
               
            when KartengrundFluss.KartenflusslisteKernArray'Range =>
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
            when KartengrundRessourcen.KartenressourcenlisteLandArray'Range =>
               Kartenressourcenliste (KartenressourcenSchleifenwert) := KartengrundRessourcen.KartenressourcenlisteLand (KartenressourcenSchleifenwert);
               
            when KartengrundRessourcen.KartenressourcenlisteWasserArray'Range =>
               Kartenressourcenliste (KartenressourcenSchleifenwert) := KartengrundRessourcen.KartenressourcenlisteWasser (KartenressourcenSchleifenwert);
         end case;
         
      end loop KartenressourcenSchleife;
      
   end StandardKartenressourcenDatenbankLaden;
   
   

   procedure KartengrundDatenbankSpeichern
   is begin
      
      SchreibenDatenbankenLogik.SchreibenKartenDatenbanken;
      
   end KartengrundDatenbankSpeichern;

end KartenDatenbank;
