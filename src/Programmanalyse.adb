pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Float_Text_IO;
use Ada.Wide_Wide_Text_IO;

with GlobaleKonstanten, GlobaleDatentypen;
use GlobaleDatentypen;

with FelderwerteFestlegen;

package body Programmanalyse is

   procedure Auswahl
   is begin
      
      -- DatentypGröße;   
      
      DurchlaufSchleife:
      for DurchlaufSchleifenwert in 1 .. 10 loop
         
         Karten.Kartengröße := 9;
         Put_Line (Item => "Durchlaufnummer:" & DurchlaufSchleifenwert'Wide_Wide_Image);
         KartenfelderBewertenTesten;
         
      end loop DurchlaufSchleife;
      
   end Auswahl;
     
     

   procedure DatentypGröße
   is begin

      Put (Item => "Belegte Bits: ");
      Ada.Float_Text_IO.Put (Item => Bit,
                             Exp  => 0);
      New_Line;
      
      Put (Item => "Belegte Bytes: ");
      Ada.Float_Text_IO.Put (Item => Byte,
                             Exp  => 0);
      New_Line;
      
      Put (Item => "Belegte Kilobytes: ");
      Ada.Float_Text_IO.Put (Item => Kilobyte,
                             Exp  => 0);
      New_Line;
      
      Put (Item => "Belegte Megabytes: ");
      Ada.Float_Text_IO.Put (Item => Megabyte,
                             Exp  => 0);
      New_Line;

      Get_Immediate (Taste);
      
   end DatentypGröße;
   
   
   
   procedure KartenfelderBewertenTesten
   is
         
      task UnterwasserUnterirdisch;
      task PlanetenInneres;
      
      task body UnterwasserUnterirdisch
      is begin
         
         YAchseUnterwasserSchleife:
         for YAchseUnterwasserSchleifenwert in Karten.WeltkarteArray'First (2) + GlobaleKonstanten.Eisrand .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - GlobaleKonstanten.Eisrand loop
            XAchseUnterwasserSchleife:
            for XAchseUnterwasserSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
               
               FelderwerteFestlegen.KartenfelderBewerten (GenerierungExtern => True,
                                                          KoordinatenExtern => (-1, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert));
               
            end loop XAchseUnterwasserSchleife;
         end loop YAchseUnterwasserSchleife;
         
      end UnterwasserUnterirdisch;
      
      
      
      task body PlanetenInneres
      is begin
         
         YAchseInneresSchleife:
         for YAchseInneresSchleifenwert in Karten.WeltkarteArray'First (2) + GlobaleKonstanten.Eisrand .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - GlobaleKonstanten.Eisrand loop
            XAchseInneresSchleife:
            for XAchseInneresSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
               
               FelderwerteFestlegen.KartenfelderBewerten (GenerierungExtern => True,
                                                          KoordinatenExtern => (-2, YAchseInneresSchleifenwert, XAchseInneresSchleifenwert));
               
            end loop XAchseInneresSchleife;
         end loop YAchseInneresSchleife;
         
      end PlanetenInneres;
      
   begin
      
      YAchseSchleife:
      for YAchseSchleifenwert in Karten.WeltkarteArray'First (2) + GlobaleKonstanten.Eisrand .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - GlobaleKonstanten.Eisrand loop
         XAchseSchleife:
         for XAchseSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
            
            FelderwerteFestlegen.KartenfelderBewerten (GenerierungExtern => True,
                                                       KoordinatenExtern => (0, YAchseSchleifenwert, XAchseSchleifenwert));
               
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end KartenfelderBewertenTesten;

end Programmanalyse;
