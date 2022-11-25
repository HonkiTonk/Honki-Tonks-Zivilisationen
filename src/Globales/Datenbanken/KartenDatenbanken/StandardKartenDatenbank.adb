with KartengrundDatentypen;
with KartenDatenbank;

with BasisgrundHimmel;
with BasisgrundKern;
with BasisgrundOberflaeche;
with BasisgrundSonstiges;
with BasisgrundUnterflaeche;
with BasisgrundWeltall;
with ZusatzgrundOberflaeche;
with ZusatzgrundUnterflaeche;
with KartenextraDatentypen;
with KartengrundFluss;
with KartengrundRessourcen;

package body StandardKartenDatenbank is

   procedure StandardBasisgrundDatenbankLaden
   is begin
      
      BasisgrundSchleife:
      for BasisgrundSchleifenwert in KartengrundDatentypen.Basisgrund_Vorhanden_Enum'Range loop
         
         case
           BasisgrundSchleifenwert
         is
            when BasisgrundWeltall.BasisgrundlisteWeltallArray'Range =>
               KartenDatenbank.Basisgrundliste (BasisgrundSchleifenwert) := BasisgrundWeltall.BasisgrundlisteWeltall (BasisgrundSchleifenwert);
               
            when BasisgrundHimmel.BasisgrundlisteHimmelArray'Range =>
               KartenDatenbank.Basisgrundliste (BasisgrundSchleifenwert) := BasisgrundHimmel.BasisgrundlisteHimmel (BasisgrundSchleifenwert);
               
            when BasisgrundUnterflaeche.BasisgrundlisteUnterflächeArray'Range =>
               KartenDatenbank.Basisgrundliste (BasisgrundSchleifenwert) := BasisgrundUnterflaeche.BasisgrundlisteUnterfläche (BasisgrundSchleifenwert);
               
            when BasisgrundKern.BasisgrundlisteKernArray'Range =>
               KartenDatenbank.Basisgrundliste (BasisgrundSchleifenwert) := BasisgrundKern.BasisgrundlisteKern (BasisgrundSchleifenwert);
               
            when BasisgrundSonstiges.BasisgrundlisteSonstigesArray'Range =>
               KartenDatenbank.Basisgrundliste (BasisgrundSchleifenwert) := BasisgrundSonstiges.BasisgrundlisteSonstiges (BasisgrundSchleifenwert);
               
            when BasisgrundOberflaeche.BasisgrundlisteOberflächeArray'Range =>
               KartenDatenbank.Basisgrundliste (BasisgrundSchleifenwert) := BasisgrundOberflaeche.BasisgrundlisteOberfläche (BasisgrundSchleifenwert);
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
               KartenDatenbank.Zusatzgrundliste (ZusatzgrundSchleifenwert) := ZusatzgrundOberflaeche.ZusatzgrundlisteOberfläche (ZusatzgrundSchleifenwert);
               
            when ZusatzgrundUnterflaeche.ZusatzgrundlisteUnterflächeArray'Range =>
               KartenDatenbank.Zusatzgrundliste (ZusatzgrundSchleifenwert) := ZusatzgrundUnterflaeche.ZusatzgrundlisteUnterfläche (ZusatzgrundSchleifenwert);
         end case;
         
      end loop ZusatzgrundSchleife;
      
   end StandardZusatzgrundDatenbankLaden;
   
   

   procedure StandardKartenflussDatenbankLaden
   is begin
      
      KartenflussSchleife:
      for KartenflussSchleifenwert in KartenextraDatentypen.Fluss_Vorhanden_Enum'Range loop
         
         case
           KartenflussSchleifenwert
         is
            when KartengrundFluss.KartenflusslisteOberflächeArray'Range =>
               KartenDatenbank.Kartenflussliste (KartenflussSchleifenwert) := KartengrundFluss.KartenflusslisteOberfläche (KartenflussSchleifenwert);
               
            when KartengrundFluss.KartenflusslisteUnterflächeArray'Range =>
               KartenDatenbank.Kartenflussliste (KartenflussSchleifenwert) := KartengrundFluss.KartenflusslisteUnterfläche (KartenflussSchleifenwert);
               
            when KartengrundFluss.KartenflusslisteKernArray'Range =>
               KartenDatenbank.Kartenflussliste (KartenflussSchleifenwert) := KartengrundFluss.KartenflusslisteKern (KartenflussSchleifenwert);
         end case;
         
      end loop KartenflussSchleife;
      
   end StandardKartenflussDatenbankLaden;
   
   

   procedure StandardKartenressourcenDatenbankLaden
   is begin
      
      KartenressourcenSchleife:
      for KartenressourcenSchleifenwert in KartenextraDatentypen.Ressourcen_Vorhanden_Enum'Range loop
         
         case
           KartenressourcenSchleifenwert
         is
            when KartengrundRessourcen.KartenressourcenlisteLandArray'Range =>
               KartenDatenbank.Kartenressourcenliste (KartenressourcenSchleifenwert) := KartengrundRessourcen.KartenressourcenlisteLand (KartenressourcenSchleifenwert);
               
            when KartengrundRessourcen.KartenressourcenlisteWasserArray'Range =>
               KartenDatenbank.Kartenressourcenliste (KartenressourcenSchleifenwert) := KartengrundRessourcen.KartenressourcenlisteWasser (KartenressourcenSchleifenwert);
         end case;
         
      end loop KartenressourcenSchleife;
      
   end StandardKartenressourcenDatenbankLaden;

end StandardKartenDatenbank;
