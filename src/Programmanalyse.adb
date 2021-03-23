pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Float_Text_IO;
use Ada.Wide_Wide_Text_IO;

with GlobaleDatentypen;

with KartenPruefungen;

package body Programmanalyse is

   procedure Auswahl is
   begin
      
      DatentypGröße;
      WerteAufrufprüfung;
      
   end Auswahl;
     
     

   procedure DatentypGröße is
   begin

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



   procedure WerteAufrufprüfung is
   begin

      Put_Line (Item => "Los gehts!");

      KartengrößeSchleife:
      for KartengrößeSchleifenwert in 1 .. 9 loop
         Put_Line (Item => KartengrößeSchleifenwert'Wide_Wide_Image);
         Karten.Kartengröße := KartengrößeSchleifenwert;

         EAchseSchleife:
         for EAchseSchleifenwert in GlobaleDatentypen.Ebene'Range loop
            YAchseSchleife:
            for YAchseSchleifenwert in GlobaleDatentypen.Kartenfeld'Range loop
               XAchseSchleife:
               for XAchseSchleifenwert in GlobaleDatentypen.Kartenfeld'Range loop

                  EAchseZweiSchleife:
                  for EAchseZweiSchleifenwert in GlobaleDatentypen.EbeneVorhanden'Range loop
                     YAchseZweiSchleife:
                     for YAchseZweiSchleifenwert in GlobaleDatentypen.KartenfeldPositiv'First .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße loop
                        XAchseZweiSchleife:
                        for XAchseZweiSchleifenwert in GlobaleDatentypen.KartenfeldPositiv'First .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße loop

                           AbstandSchleife:
                           for AbstandSchleifenwert in 0 .. GlobaleDatentypen.Kartenfeld'Last loop

                              Kartenwert := KartenPruefungen.KartenPositionBestimmen (KoordinatenExtern    => (EAchseZweiSchleifenwert, YAchseZweiSchleifenwert, XAchseZweiSchleifenwert),
                                                                                      ÄnderungExtern       => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                      ZusatzYAbstandExtern => AbstandSchleifenwert);

                           end loop AbstandSchleife;

                        end loop XAchseZweiSchleife;
                     end loop YAchseZweiSchleife;
                  end loop EAchseZweiSchleife;
                        
               end loop XAchseSchleife;
            end loop YAchseSchleife;
         end loop EAchseSchleife;

      end loop KartengrößeSchleife;
      
      Put_Line (Item => "Fertig!");
      Get_Immediate (Taste);
      
   end WerteAufrufprüfung;

end Programmanalyse;
