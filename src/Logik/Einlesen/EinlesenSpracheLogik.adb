with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;

with GlobaleTexte;
with TextKonstanten;
with VerzeichnisKonstanten;

with EinlesenAllgemeinesLogik;

package body EinlesenSpracheLogik is

   function EinlesenSprache
     return Boolean
   is begin
      
      GlobaleTexte.SprachenEinlesen := (others => TextKonstanten.LeerUnboundedString);
            
      Start_Search (Search    => Suche,
                    Directory => VerzeichnisKonstanten.Sprachen,
                    Pattern   => "",
                    Filter    => (Directory => True,
                                  others    => False));
      
      VerzeichnisAußenSchleife:
      while More_Entries (Search => Suche) = True loop

      
         Get_Next_Entry (Search          => Suche,
                         Directory_Entry => Verzeichnis);
         
         if
           Simple_Name (Directory_Entry => Verzeichnis) = "."
           or
             Simple_Name (Directory_Entry => Verzeichnis) = ".."
           or
             Simple_Name (Directory_Entry => Verzeichnis) = "Fonts"
         then
            null;
            
         elsif
           -- Das hier noch durch eine Windows uns eine Linuxversion ersetzen. äöü
           -- Kann das nicht einfach raus wenn irgendwann einmal Wide_Wide_Directories da ist? äöü
           -- Das ist je nur vorhandene Ordner durchgehen und man kann ja keine Dateien/Ordner anlegen die das Dateisystem nicht unterstützen. äöü
           EinlesenAllgemeinesLogik.NamensprüfungWindows (NameExtern => Decode (Item => Simple_Name (Directory_Entry => Verzeichnis))) = False
         then
            null;
             
         elsif
           -- Das ausgeklammerte funktioniert unter Windwos nicht, wenn man Sonderzeichen verwendet.
           -- EinlesenAllgemeinesLogik.LeeresVerzeichnis (VerzeichnisExtern => VerzeichnisKonstanten.SprachenStrich & Simple_Name (Directory_Entry => Verzeichnis)) = True
           Exists (Name => VerzeichnisKonstanten.SprachenStrich & Simple_Name (Directory_Entry => Verzeichnis) & VerzeichnisKonstanten.NullDatei) = False
           or
             Exists (Name => VerzeichnisKonstanten.SprachenStrich & Simple_Name (Directory_Entry => Verzeichnis) & VerzeichnisKonstanten.EinsDatei) = False
         then
            null;
            
         else
            Test := To_Unbounded_Wide_Wide_String (Source => Decode (Item => Simple_Name (Directory_Entry => Verzeichnis)));
            
            VerzeichnisInnenSchleife:
            for SpracheSchleifenwert in GlobaleTexte.SprachenEinlesen'Range loop
               if
                 GlobaleTexte.SprachenEinlesen (SpracheSchleifenwert) /= TextKonstanten.LeerUnboundedString
               then
                  null;
            
               else
                  GlobaleTexte.SprachenEinlesen (SpracheSchleifenwert) := Test;
                  exit VerzeichnisInnenSchleife;
               end if;
         
            end loop VerzeichnisInnenSchleife;
         end if;

      end loop VerzeichnisAußenSchleife;
      
      if
        GlobaleTexte.SprachenEinlesen (1) = TextKonstanten.LeerUnboundedString
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
      for PositionSchleifenwert in GlobaleTexte.SprachenEinlesen'First + 1 .. GlobaleTexte.SprachenEinlesen'Last loop
         
         if
           GlobaleTexte.SprachenEinlesen (PositionSchleifenwert) = TextKonstanten.LeerUnboundedString
         then
            exit SortierSchleife;
            
         else
            SchleifenAbzug := 0;
            PrüfSchleife:
            loop
               
               if
                 PositionSchleifenwert - SchleifenAbzug > GlobaleTexte.SprachenEinlesen'First
                 and then
                   GlobaleTexte.SprachenEinlesen (PositionSchleifenwert) < GlobaleTexte.SprachenEinlesen (PositionSchleifenwert - SchleifenAbzug - 1)
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
                     
                     ZwischenSpeicher := GlobaleTexte.SprachenEinlesen (PositionSchleifenwert);
                     GlobaleTexte.SprachenEinlesen (PositionSchleifenwert) := GlobaleTexte.SprachenEinlesen (PositionSchleifenwert - SchleifenAbzug);
                     GlobaleTexte.SprachenEinlesen (PositionSchleifenwert - SchleifenAbzug) := ZwischenSpeicher;
                     SchleifenAbzug := SchleifenAbzug - 1;
                     
                  end loop VerschiebungSchleife;
                  
                  exit PrüfSchleife;
               end if;
               
            end loop PrüfSchleife;
         end if;
         
      end loop SortierSchleife;
      
   end SprachenSortieren;

end EinlesenSpracheLogik;
