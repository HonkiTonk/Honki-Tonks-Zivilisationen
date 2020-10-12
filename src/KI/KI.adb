package body KI is

   procedure KI is
   begin

      RassenAbgearbeitet := 2;
      
      RasseSchleife:
      for Rasse in GlobaleVariablen.RassenImSpiel'Range loop
         
         case GlobaleVariablen.RassenImSpiel (Rasse) is
            when 0 => -- Nicht belegt
               null;
               
            when 1 => -- Menschlicher Spieler
               null;
               
            when others => -- KI
               KIAktivität (Rasse => Rasse);
               if RassenAbgearbeitet = GlobaleVariablen.SpielerAnzahl then
                  return;
                        
               else
                  RassenAbgearbeitet := RassenAbgearbeitet + 1;
               end if;               
         end case;         

      end loop RasseSchleife;
      
   end KI;



   procedure KIAktivität (Rasse : in Integer) is -- Von hier aus dann die einzelnen Tätigkeiten aufrufen
   begin
      
      AktivitätSchleife:
      loop
         
         exit AktivitätSchleife;
         
      end loop AktivitätSchleife;
      
   end KIAktivität;



   procedure KIBewegung (Rasse : in Integer) is
   begin
      
      null;
      
   end KIBewegung;
   
   
   
   procedure KIStadtBauen (Rasse : in Integer) is
   begin
      
      null;
      
   end KIStadtBauen;
   
   
   
   procedure KIVerbesserungAnlegen (Rasse : in Integer) is
   begin
      
      null;
      
   end KIVerbesserungAnlegen;



   procedure KIGebäudeBauen (Rasse : in Integer) is
   begin
      
      null;
      
   end KIGebäudeBauen;

end KI;
