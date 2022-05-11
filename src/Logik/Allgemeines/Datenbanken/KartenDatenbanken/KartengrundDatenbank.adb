pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartengrundHimmel;
with KartengrundKern;
with KartengrundOberflaeche;
with KartengrundSonstiges;
with KartengrundUnterflaeche;
with KartengrundWeltall;

package body KartengrundDatenbank is
   
   procedure StandardKartengrundDatenbankLaden
   is
   
      task Weltraum;
      task Himmel;
      
      task Unterfläche;
      task Kern;
      
      task Sonstiges;
      
      task body Weltraum
      is begin
         
         WeltraumSchleife:
         for WeltraumSchleifenwert in KartengrundDatentypen.Kartengrund_Weltraum_Enum'Range loop
         
            Kartengrundliste (WeltraumSchleifenwert) := KartengrundWeltall.KartengrundlisteWeltall (WeltraumSchleifenwert);
         
         end loop WeltraumSchleife;
         
      end Weltraum;
      
      
      
      task body Himmel
      is begin
         
         HimmelSchleife:
         for HimmelSchleifenwert in KartengrundDatentypen.Kartengrund_Himmel_Enum'Range loop
            
            Kartengrundliste (HimmelSchleifenwert) := KartengrundHimmel.KartengrundlisteHimmel (HimmelSchleifenwert);
                        
         end loop HimmelSchleife;
         
      end Himmel;
      
      
      
      task body Unterfläche
      is begin
         
         UnterflächeSchleife:
         for UnterflächeSchleifenwert in KartengrundDatentypen.Kartengrund_Unterfläche_Enum'Range loop
            
            Kartengrundliste (UnterflächeSchleifenwert) := KartengrundUnterflaeche.KartengrundlisteUnterfläche (UnterflächeSchleifenwert);
            
         end loop UnterflächeSchleife;
         
      end Unterfläche;
      
      
      
      task body Kern
      is begin
         
         KernSchleife:
         for KernSchleifenwert in KartengrundDatentypen.Kartengrund_Kernfläche_Enum'Range loop
            
            Kartengrundliste (KernSchleifenwert) := KartengrundKern.KartengrundlisteKern (KernSchleifenwert);
            
         end loop KernSchleife;
         
      end Kern;
      
      
      
      task body Sonstiges
      is begin
         
         SonstigesSchleife:
         for SonstigesSchleifenwert in KartengrundDatentypen.Kartengrund_Sonstiges_Enum'Range loop
            
            Kartengrundliste (SonstigesSchleifenwert) := KartengrundSonstiges.KartengrundlisteSonstiges (SonstigesSchleifenwert);
            
         end loop SonstigesSchleife;
         
      end Sonstiges;
   
   begin
      
      OberflächeSchleife:
      for OberflächeSchleifenwert in KartengrundDatentypen.Kartengrund_Oberfläche_Enum'Range loop
         
         Kartengrundliste (OberflächeSchleifenwert) := KartengrundOberflaeche.KartengrundlisteOberfläche (OberflächeSchleifenwert);
         
      end loop OberflächeSchleife;
      
   end StandardKartengrundDatenbankLaden;

end KartengrundDatenbank;
