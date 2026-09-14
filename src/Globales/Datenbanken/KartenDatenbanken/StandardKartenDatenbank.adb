with KartenzusatzgrundDatentypen;
with KartenDatenbank;
with KartenrohstoffeDatentypen;
with KartenbasisgrundDatentypen;

with BasisgrundHimmel;
with BasisgrundKern;
with BasisgrundOberflaeche;
with BasisgrundSonstiges;
with BasisgrundUnterflaeche;
with BasisgrundOrbit;
with ZusatzgrundOberflaeche;
with ZusatzgrundUnterflaeche;
with KartenfluesseDatentypen;
with KartengrundFluss;
with Landrohstoffe;
with Wasserrohstoffe;

package body StandardKartenDatenbank is

   procedure StandardBasisgrundDatenbankLaden
   is begin
      
      BasisgrundSchleife:
      for BasisgrundSchleifenwert in KartenbasisgrundDatentypen.Basisgrund_Vorhanden_Enum'Range loop
         
         case
           BasisgrundSchleifenwert
         is
            when BasisgrundOrbit.BasisgrundlisteOrbitArray'Range =>
               KartenDatenbank.Basisgrundliste (BasisgrundSchleifenwert) := BasisgrundOrbit.BasisgrundlisteOrbit (BasisgrundSchleifenwert);
               
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
      for ZusatzgrundSchleifenwert in KartenzusatzgrundDatentypen.Zusatzgrund_Vorhanden_Enum'Range loop
         
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
      for KartenflussSchleifenwert in KartenfluesseDatentypen.Fluss_Vorhanden_Enum'Range loop
         
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
   
   

   procedure StandardKartenrohstoffeDatenbankLaden
   is begin
      
      KartenrohstoffeSchleife:
      for KartenrohstoffeSchleifenwert in KartenrohstoffeDatentypen.Rohstoffe_Vorhanden_Enum'Range loop
         
         case
           KartenrohstoffeSchleifenwert
         is
            when Landrohstoffe.LandrohstoffelisteArray'Range =>
               KartenDatenbank.Kartenrohstoffeliste (KartenrohstoffeSchleifenwert) := Landrohstoffe.Landrohstoffeliste (KartenrohstoffeSchleifenwert);
               
            when Wasserrohstoffe.WasserrohstoffelisteArray'Range =>
               KartenDatenbank.Kartenrohstoffeliste (KartenrohstoffeSchleifenwert) := Wasserrohstoffe.Wasserrohstoffeliste (KartenrohstoffeSchleifenwert);
         end case;
         
      end loop KartenrohstoffeSchleife;
      
   end StandardKartenrohstoffeDatenbankLaden;

end StandardKartenDatenbank;
