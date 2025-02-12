with UmwandlungssystemHTSEB;
with DateisystemtestsHTSEB;

with TextArrays;
with TextKonstanten;
with VerzeichnisKonstanten;

package body EinlesenSpracheLogik is

   function EinlesenSprache
     return Boolean
   is begin
      
      TextArrays.SprachenTexturenEinlesen := (others => TextKonstanten.LeerUnboundedString);
            
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
           Simple_Name (Directory_Entry => Verzeichnis) = VerzeichnisKonstanten.FontsOrdner
         then
            null;
            
         elsif
           False = DateisystemtestsHTSEB.GültigeZeichenlänge (LinuxTextExtern   => TextKonstanten.LeerUnboundedString,
                                                                     WindowsTextExtern => UmwandlungssystemHTSEB.DecodeUnbounded (TextExtern => VerzeichnisKonstanten.SprachenStrich
                                                                                                                                         & Simple_Name (Directory_Entry => Verzeichnis)
                                                                                                                                         & VerzeichnisKonstanten.NullDatei))
         then
            null;
            
         elsif
           -- Kann das nicht einfach raus wenn irgendwann einmal Wide_Wide_Directories da ist? äöü
           -- Das ist je nur vorhandene Ordner durchgehen und man kann ja keine Dateien/Ordner anlegen die das Dateisystem nicht unterstützen. äöü
           DateisystemtestsHTSEB.GültigerNamen (NameExtern => UmwandlungssystemHTSEB.Decode (TextExtern => Simple_Name (Directory_Entry => Verzeichnis))) = False
         then
            null;
             
         elsif
           -- Das ausgeklammerte unten drunter funktioniert unter Windwos nicht, wenn man Sonderzeichen verwendet.
           -- EinlesenAllgemeinesLogik.LeeresVerzeichnis (VerzeichnisExtern => VerzeichnisKonstanten.SprachenStrich & Simple_Name (Directory_Entry => Verzeichnis)) = True
           Exists (Name => VerzeichnisKonstanten.SprachenStrich & Simple_Name (Directory_Entry => Verzeichnis) & VerzeichnisKonstanten.NullDatei) = False
         then
            null;
            
         else
            Verzeichnisname := To_Unbounded_Wide_Wide_String (Source => UmwandlungssystemHTSEB.Decode (TextExtern => Simple_Name (Directory_Entry => Verzeichnis)));
            
            VerzeichnisInnenSchleife:
            for SpracheSchleifenwert in TextArrays.SprachenTexturenEinlesen'Range loop
               if
                 TextArrays.SprachenTexturenEinlesen (SpracheSchleifenwert) /= TextKonstanten.LeerUnboundedString
               then
                  null;
            
               else
                  TextArrays.SprachenTexturenEinlesen (SpracheSchleifenwert) := Verzeichnisname;
                  exit VerzeichnisInnenSchleife;
               end if;
         
            end loop VerzeichnisInnenSchleife;
         end if;

      end loop VerzeichnisAußenSchleife;
      
      End_Search (Search => Suche);
      
      if
        TextArrays.SprachenTexturenEinlesen (1) = TextKonstanten.LeerUnboundedString
      then
         return False;
         
      else
         SprachenSortieren;
         return True;
      end if;
      
   end EinlesenSprache;
   
   
   
   -- Sollte sowas nicht auch bei den Spielständen funktionieren, wenn ich die Zeit der Erstellung abfrage und danach sortiere? äöü
   procedure SprachenSortieren
   is begin
            
      SortierSchleife:
      for PositionSchleifenwert in TextArrays.SprachenTexturenEinlesen'First + 1 .. TextArrays.SprachenTexturenEinlesen'Last loop
         
         if
           TextArrays.SprachenTexturenEinlesen (PositionSchleifenwert) = TextKonstanten.LeerUnboundedString
         then
            exit SortierSchleife;
            
         else
            SchleifenAbzug := 0;
            PrüfSchleife:
            loop
               
               if
                 PositionSchleifenwert - SchleifenAbzug > TextArrays.SprachenTexturenEinlesen'First
                 and then
                   TextArrays.SprachenTexturenEinlesen (PositionSchleifenwert) < TextArrays.SprachenTexturenEinlesen (PositionSchleifenwert - SchleifenAbzug - 1)
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
                     
                     Zwischenspeicher := TextArrays.SprachenTexturenEinlesen (PositionSchleifenwert);
                     TextArrays.SprachenTexturenEinlesen (PositionSchleifenwert) := TextArrays.SprachenTexturenEinlesen (PositionSchleifenwert - SchleifenAbzug);
                     TextArrays.SprachenTexturenEinlesen (PositionSchleifenwert - SchleifenAbzug) := Zwischenspeicher;
                     SchleifenAbzug := SchleifenAbzug - 1;
                     
                  end loop VerschiebungSchleife;
                  
                  exit PrüfSchleife;
               end if;
               
            end loop PrüfSchleife;
         end if;
         
      end loop SortierSchleife;
      
   end SprachenSortieren;

end EinlesenSpracheLogik;
