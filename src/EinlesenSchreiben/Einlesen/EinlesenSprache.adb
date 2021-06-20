pragma SPARK_Mode (On);

with Ada.Characters.Conversions;

with GlobaleVariablen;

package body EinlesenSprache is

   function EinlesenSprache
     return Boolean
   is begin

      GlobaleVariablen.SprachenEinlesen := (others => (To_Unbounded_Wide_Wide_String (Source => "|")));
      
      Start_Search (Search    => Suche,
                    Directory => "Sprachen",
                    Pattern   => "");

      VerzeichnisAußenSchleife:
      while More_Entries (Search => Suche) loop

         Get_Next_Entry (Search          => Suche,
                         Directory_Entry => Verzeichnis);
         if
           Simple_Name (Directory_Entry => Verzeichnis) = "."
           or
             Simple_Name (Directory_Entry => Verzeichnis) = ".."
         then
            null;
                  
         else
            VerzeichnisInnenSchleife:
            for SpracheSchleifenwert in GlobaleVariablen.SprachenEinlesenArray'Range loop -- Alphabetisch in ein Stringarray einlesen und dann entsprechend weitersuchen lassen
            
               if
                 GlobaleVariablen.SprachenEinlesen (SpracheSchleifenwert) /= "|"
               then
                  null;
            
               else        
                  GlobaleVariablen.SprachenEinlesen (SpracheSchleifenwert)
                    := To_Unbounded_Wide_Wide_String (Source => Ada.Characters.Conversions.To_Wide_Wide_String (Item => Simple_Name (Directory_Entry => Verzeichnis)));
                  exit VerzeichnisInnenSchleife;
               end if;            
         
            end loop VerzeichnisInnenSchleife;
         end if;

      end loop VerzeichnisAußenSchleife;
      
      if
        GlobaleVariablen.SprachenEinlesen (1) = "|"
      then
         return False;
         
      else
         SprachenSortieren;
         return True;
      end if;
      
   end EinlesenSprache;
   
   
   
   procedure SprachenSortieren
   is begin
      
      SortierSchleife:
      for PositionSchleifenwert in GlobaleVariablen.SprachenEinlesenArray'First + 1 .. GlobaleVariablen.SprachenEinlesenArray'Last loop
         
         if
           GlobaleVariablen.SprachenEinlesen (PositionSchleifenwert) = "|"
         then
            return;
            
         else
            SchleifenAbzug := 0;
            PrüfSchleife:
            loop
               
               if
                 PositionSchleifenwert - SchleifenAbzug > GlobaleVariablen.SprachenEinlesenArray'First
                 and then
                   GlobaleVariablen.SprachenEinlesen (PositionSchleifenwert) < GlobaleVariablen.SprachenEinlesen (PositionSchleifenwert - SchleifenAbzug - 1)                   
               then
                  SchleifenAbzug := SchleifenAbzug + 1;
                  
               else
                  if
                    PositionSchleifenwert = SchleifenAbzug
                  then
                     SchleifenAbzug := SchleifenAbzug - 1;
                     
                  else
                     null;
                  end if;
                  
                  VerschiebungSchleife:
                  while SchleifenAbzug > 0 loop
                     
                     ZwischenSpeicher := GlobaleVariablen.SprachenEinlesen (PositionSchleifenwert);
                     GlobaleVariablen.SprachenEinlesen (PositionSchleifenwert) := GlobaleVariablen.SprachenEinlesen (PositionSchleifenwert - SchleifenAbzug);
                     GlobaleVariablen.SprachenEinlesen (PositionSchleifenwert - SchleifenAbzug) := ZwischenSpeicher;
                     SchleifenAbzug := SchleifenAbzug - 1;
                     
                  end loop VerschiebungSchleife;
                  exit PrüfSchleife;
               end if;
               
            end loop PrüfSchleife;
         end if;
         
      end loop SortierSchleife;
      
   end SprachenSortieren;

end EinlesenSprache;
