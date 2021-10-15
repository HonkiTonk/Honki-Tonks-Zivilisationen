pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

package body TextAnzeigeKonsole is

   procedure AnzeigeMitAuswahl
     (FrageDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      TextDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      FrageZeileExtern : in Natural;
      ErsteZeileExtern : in Natural;
      LetzteZeileExtern : in Natural;
      AktuelleAuswahlExtern : in Positive)
   is begin
      
      LängsterText := 1;
      
      TextlängePrüfenSchleife:
      for ZeilenSchleifenwert in ErsteZeileExtern .. LetzteZeileExtern loop
         
         if
           To_Wide_Wide_String (Source => GlobaleTexte.TexteEinlesenNeu (GlobaleTexte.Welche_Datei_Enum'Pos (TextDateiExtern), ZeilenSchleifenwert))'Length > LängsterText
         then
            LängsterText := To_Wide_Wide_String (Source => GlobaleTexte.TexteEinlesenNeu (GlobaleTexte.Welche_Datei_Enum'Pos (TextDateiExtern), ZeilenSchleifenwert))'Length;
            
         else
            null;
         end if;
         
      end loop TextlängePrüfenSchleife;
      
      Überschrift (FrageDateiExtern => FrageDateiExtern,
                    FrageZeileExtern => FrageZeileExtern);
      
      AnzeigeSchleife:
      for ZeileSchleifenwert in ErsteZeileExtern .. LetzteZeileExtern loop
         
         if
           AktuelleAuswahlExtern = ZeileSchleifenwert
         then
            
            RahmenTeilEinsSchleife:
            for TextlängeEins in 1 .. LängsterText loop
                  
               if
                 TextlängeEins = 1
               then
                  
                  Put (Item => "╔");
                  Put (Item => "═");

               elsif
                 TextlängeEins = LängsterText
               then
                  Put (Item => "═");
                  Put_Line (Item => "╗");
                  Put (Item => "║");
                  Put (Item => To_Wide_Wide_String (Source => GlobaleTexte.TexteEinlesenNeu (GlobaleTexte.Welche_Datei_Enum'Pos (TextDateiExtern), ZeileSchleifenwert)));

                  LeererPlatzSchleife:
                  for LeererPlatz in 1 .. LängsterText - To_Wide_Wide_String (Source => GlobaleTexte.TexteEinlesenNeu (GlobaleTexte.Welche_Datei_Enum'Pos (TextDateiExtern), ZeileSchleifenwert))'Length loop
                     
                     Put (" ");
                        
                  end loop LeererPlatzSchleife;

                  Put_Line (Item => "║");
                  Put (Item => "╚");

               else
                  Put (Item => "═");
               end if;
               
            end loop RahmenTeilEinsSchleife;

            RahmenTeilZweiSchleife:
            for TextlängeZweiSchleifenwert in 1 .. LängsterText loop
               
               if
                 TextlängeZweiSchleifenwert = LängsterText
               then
                  Put (Item => "═");
                  Put_Line (Item => "╝");
               
               else
                  Put (Item => "═");
               end if;
            
            end loop RahmenTeilZweiSchleife;
         
         else
            Put_Line (Item => To_Wide_Wide_String (Source => GlobaleTexte.TexteEinlesenNeu (GlobaleTexte.Welche_Datei_Enum'Pos (TextDateiExtern), ZeileSchleifenwert)));
         end if;
         
      end loop AnzeigeSchleife;
      
   end AnzeigeMitAuswahl;
   
   
   
   procedure AnzeigeOhneAuswahl
     (ÜberschriftDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      TextDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      ÜberschriftZeileExtern : in Natural;
      ErsteZeileExtern : in Positive;
      LetzteZeileExtern : in Positive;
      AbstandAnfangExtern : in GlobaleTexte.Welcher_Abstand_Enum;
      AbstandMitteExtern : in GlobaleTexte.Welcher_Abstand_Enum;
      AbstandEndeExtern : in GlobaleTexte.Welcher_Abstand_Enum)
   is begin
      
      Überschrift (FrageDateiExtern => ÜberschriftDateiExtern,
                    FrageZeileExtern => ÜberschriftZeileExtern);

      AbstandEinbauen (AbstandExtern => AbstandAnfangExtern);

      TextAnzeigeSchleife:
      for TextZeileSchleifenwert in ErsteZeileExtern .. LetzteZeileExtern loop
         
         Put (Item => To_Wide_Wide_String (Source => GlobaleTexte.TexteEinlesenNeu (GlobaleTexte.Welche_Datei_Enum'Pos (TextDateiExtern), TextZeileSchleifenwert)));
                  
         if
           ErsteZeileExtern = LetzteZeileExtern
           or
             AbstandMitteExtern = GlobaleTexte.Leer
         then
            null;
            
         elsif
           ErsteZeileExtern < LetzteZeileExtern
         then
            AbstandEinbauen (AbstandExtern => AbstandMitteExtern);

         else
            null;
         end if;

      end loop TextAnzeigeSchleife;
      
      AbstandEinbauen (AbstandExtern => AbstandEndeExtern);
      
   end AnzeigeOhneAuswahl;
   
   
   
   procedure Überschrift
     (FrageDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      FrageZeileExtern : in Natural)
   is begin
      
      case
        FrageDateiExtern
      is
         when GlobaleTexte.Leer =>
            null;

         when others =>
            Put_Line (Item => To_Wide_Wide_String (Source => GlobaleTexte.TexteEinlesenNeu (GlobaleTexte.Welche_Datei_Enum'Pos (FrageDateiExtern), FrageZeileExtern)));
      end case;
      
   end Überschrift;
   
   
   
   procedure AbstandEinbauen
     (AbstandExtern : in GlobaleTexte.Welcher_Abstand_Enum)
   is begin
      
      case
        AbstandExtern
      is
         when GlobaleTexte.Leer =>
            null;

         when GlobaleTexte.Kleiner_Abstand =>
            Put (Item => " ");
            
         when GlobaleTexte.Großer_Abstand =>
            Put (Item => "    ");
            
         when GlobaleTexte.Neue_Zeile =>
            New_Line;
      end case;
      
   end AbstandEinbauen;

end TextAnzeigeKonsole;
