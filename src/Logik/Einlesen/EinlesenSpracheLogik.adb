with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;
with Ada.Characters.Wide_Wide_Latin_1; use Ada.Characters.Wide_Wide_Latin_1;

with GlobaleTexte;
with TextKonstanten;
with VerzeichnisKonstanten;
-- with EinlesenAllgemeinesLogik;

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
           Ordnernamen (NameExtern => Decode (Item => Simple_Name (Directory_Entry => Verzeichnis))) = False
         then
            null;
             
         elsif
           -- Das ausgeklammerte funktioniert unter Windwos nicht, wenn man Sonderzeichen verwendet.
           -- EinlesenAllgemeinesLogik.LeeresVerzeichnis (VerzeichnisExtern => VerzeichnisKonstanten.SprachenStrich & Simple_Name (Directory_Entry => Verzeichnis)) = True
           Exists (Name => VerzeichnisKonstanten.SprachenStrich & Simple_Name (Directory_Entry => Verzeichnis) & "/0") = False
           or
             Exists (Name => VerzeichnisKonstanten.SprachenStrich & Simple_Name (Directory_Entry => Verzeichnis) & "/1") = False
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
   
   
   
   function Ordnernamen
     (NameExtern : in Wide_Wide_String)
      return Boolean
   is begin
      
      NamenSchleife:
      for NamenSchleifenwert in NameExtern'Range loop
         
         case
           NameExtern (NamenSchleifenwert)
         is
            when 'a' .. 'z' | 'A' .. 'Z' | '0' .. '9' | Space | Hyphen | Low_Line | Full_Stop =>
               null;
               
            when others =>
               return False;
         end case;
         
      end loop NamenSchleife;
      
      return True;
      
   end Ordnernamen;
   
   
   
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
