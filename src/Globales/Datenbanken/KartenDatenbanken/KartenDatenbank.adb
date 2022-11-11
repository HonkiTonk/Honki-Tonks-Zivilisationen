with SchreibenDatenbankenLogik;

with BasisgrundHimmel;
with BasisgrundKern;
with BasisgrundOberflaeche;
with BasisgrundSonstiges;
with BasisgrundUnterflaeche;
with BasisgrundWeltall;
with ZusatzgrundOberflaeche;
with ZusatzgrundUnterflaeche;
with KartengrundFluss;
with KartengrundRessourcen;

package body KartenDatenbank is
   
   procedure StandardBasisgrundDatenbankLaden
   is begin
      
      BasisgrundSchleife:
      for BasisgrundSchleifenwert in KartengrundDatentypen.Basisgrund_Vorhanden_Enum'Range loop
         
         case
           BasisgrundSchleifenwert
         is
            when BasisgrundWeltall.BasisgrundlisteWeltallArray'Range =>
               Basisgrundliste (BasisgrundSchleifenwert) := BasisgrundWeltall.BasisgrundlisteWeltall (BasisgrundSchleifenwert);
               
            when BasisgrundHimmel.BasisgrundlisteHimmelArray'Range =>
               Basisgrundliste (BasisgrundSchleifenwert) := BasisgrundHimmel.BasisgrundlisteHimmel (BasisgrundSchleifenwert);
               
            when BasisgrundUnterflaeche.BasisgrundlisteUnterflächeArray'Range =>
               Basisgrundliste (BasisgrundSchleifenwert) := BasisgrundUnterflaeche.BasisgrundlisteUnterfläche (BasisgrundSchleifenwert);
               
            when BasisgrundKern.BasisgrundlisteKernArray'Range =>
               Basisgrundliste (BasisgrundSchleifenwert) := BasisgrundKern.BasisgrundlisteKern (BasisgrundSchleifenwert);
               
            when BasisgrundSonstiges.BasisgrundlisteSonstigesArray'Range =>
               Basisgrundliste (BasisgrundSchleifenwert) := BasisgrundSonstiges.BasisgrundlisteSonstiges (BasisgrundSchleifenwert);
               
            when BasisgrundOberflaeche.BasisgrundlisteOberflächeArray'Range =>
               Basisgrundliste (BasisgrundSchleifenwert) := BasisgrundOberflaeche.BasisgrundlisteOberfläche (BasisgrundSchleifenwert);
         end case;
         
      end loop BasisgrundSchleife;
      
   end StandardBasisgrundDatenbankLaden;
   
   
   
   procedure StandardZusatzgrundDatenbankLaden
   is begin
      
      ZusatzgrundSchleife:
      for ZusatzgrundSchleifenwert in KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum'Range loop
         
         case
           ZusatzgrundSchleifenwert
         is
            when ZusatzgrundOberflaeche.ZusatzgrundlisteOberflächeArray'Range =>
               Zusatzgrundliste (ZusatzgrundSchleifenwert) := ZusatzgrundOberflaeche.ZusatzgrundlisteOberfläche (ZusatzgrundSchleifenwert);
               
            when ZusatzgrundUnterflaeche.ZusatzgrundlisteUnterflächeArray'Range =>
               Zusatzgrundliste (ZusatzgrundSchleifenwert) := ZusatzgrundUnterflaeche.ZusatzgrundlisteUnterfläche (ZusatzgrundSchleifenwert);
         end case;
         
      end loop ZusatzgrundSchleife;
      
   end StandardZusatzgrundDatenbankLaden;
   
   

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
