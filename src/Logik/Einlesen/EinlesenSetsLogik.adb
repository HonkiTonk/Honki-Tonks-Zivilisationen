with DateisystemtestsHTSEB;
with UmwandlungssystemHTSEB;
with VerzeichnisKonstanten;
with ArraysHTSEB;
with TextKonstantenHTSEB;

package body EinlesenSetsLogik is

   function EinlesenSets
     (OrdnerExtern : in String)
      return Boolean
   is begin
      
      ArraysHTSEB.SetsEinlesen := (others => TextKonstantenHTSEB.LeerUnboundedString);
            
      Start_Search (Search    => Suche,
                    Directory => OrdnerExtern,
                    Pattern   => "",
                    Filter    => (Directory => True,
                                  others    => False));
      
      VerzeichnisAußenSchleife:
      while More_Entries (Search => Suche) = True loop
      
         Get_Next_Entry (Search          => Suche,
                         Directory_Entry => Verzeichnis);
         
         if
           OrdnerExtern = VerzeichnisKonstanten.Sprachen
           and
             Simple_Name (Directory_Entry => Verzeichnis) = VerzeichnisKonstanten.FontsOrdner
         then
            null;
            
         elsif
           False = DateisystemtestsHTSEB.GültigeZeichenlänge (LinuxTextExtern   => TextKonstantenHTSEB.LeerUnboundedString,
                                                                WindowsTextExtern => UmwandlungssystemHTSEB.DecodeUnbounded (TextExtern => OrdnerExtern & "/"
                                                                                                                             & Simple_Name (Directory_Entry => Verzeichnis)
                                                                                                                             & VerzeichnisKonstanten.NullDatei))
         then
            null;
            
         elsif
           -- Kann das nicht einfach raus wenn irgendwann einmal Wide_Wide_Directories da ist? äöü
           -- Das ist je nur vorhandene Ordner durchgehen und man kann ja keine Dateien/Ordner anlegen die das Dateisystem nicht unterstützen. äöü
           -- Kann das dank dem Encode nicht jetzt schon raus? äöü
           DateisystemtestsHTSEB.GültigerNamen (NameExtern => UmwandlungssystemHTSEB.Decode (TextExtern => Simple_Name (Directory_Entry => Verzeichnis))) = False
         then
            null;
             
         elsif
           -- Das ausgeklammerte unten drunter funktioniert unter Windwos nicht, wenn man Sonderzeichen verwendet.
           -- EinlesenAllgemeinesHTSEB.LeeresVerzeichnis (VerzeichnisExtern => OrdnerExtern & "/" & Simple_Name (Directory_Entry => Verzeichnis)) = True
           Exists (Name => OrdnerExtern & "/" & Simple_Name (Directory_Entry => Verzeichnis) & VerzeichnisKonstanten.NullDatei) = False
         then
            null;
            
         else
            Verzeichnisname := To_Unbounded_Wide_Wide_String (Source => UmwandlungssystemHTSEB.Decode (TextExtern => Simple_Name (Directory_Entry => Verzeichnis)));
            
            VerzeichnisInnenSchleife:
            for SetSchleifenwert in ArraysHTSEB.SetsEinlesen'Range loop
               if
                 ArraysHTSEB.SetsEinlesen (SetSchleifenwert) /= TextKonstantenHTSEB.LeerUnboundedString
               then
                  null;
            
               else
                  ArraysHTSEB.SetsEinlesen (SetSchleifenwert) := Verzeichnisname;
                  exit VerzeichnisInnenSchleife;
               end if;
         
            end loop VerzeichnisInnenSchleife;
         end if;

      end loop VerzeichnisAußenSchleife;
      
      End_Search (Search => Suche);
      
      if
        ArraysHTSEB.SetsEinlesen (1) = TextKonstantenHTSEB.LeerUnboundedString
      then
         return False;
         
      else
         SetsSortieren;
         return True;
      end if;
      
   end EinlesenSets;
   
   
   
   -- Sollte sowas nicht auch bei den Spielständen funktionieren, wenn ich die Zeit der Erstellung abfrage und danach sortiere? äöü
   -- Vermutlich nicht, da das Spielstandsystem komplexer ist als die Sets, aber trotzdem mal drüber nachdenken. äöü
   procedure SetsSortieren
   is begin
            
      SortierSchleife:
      for PositionSchleifenwert in ArraysHTSEB.SetsEinlesen'First + 1 .. ArraysHTSEB.SetsEinlesen'Last loop
         
         if
           ArraysHTSEB.SetsEinlesen (PositionSchleifenwert) = TextKonstantenHTSEB.LeerUnboundedString
         then
            exit SortierSchleife;
            
         else
            SchleifenAbzug := 0;
            PrüfSchleife:
            loop
               
               if
                 PositionSchleifenwert - SchleifenAbzug > ArraysHTSEB.SetsEinlesen'First
                 and then
                   ArraysHTSEB.SetsEinlesen (PositionSchleifenwert) < ArraysHTSEB.SetsEinlesen (PositionSchleifenwert - SchleifenAbzug - 1)
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
                     
                     Zwischenspeicher := ArraysHTSEB.SetsEinlesen (PositionSchleifenwert);
                     ArraysHTSEB.SetsEinlesen (PositionSchleifenwert) := ArraysHTSEB.SetsEinlesen (PositionSchleifenwert - SchleifenAbzug);
                     ArraysHTSEB.SetsEinlesen (PositionSchleifenwert - SchleifenAbzug) := Zwischenspeicher;
                     SchleifenAbzug := SchleifenAbzug - 1;
                     
                  end loop VerschiebungSchleife;
                  
                  exit PrüfSchleife;
               end if;
               
            end loop PrüfSchleife;
         end if;
         
      end loop SortierSchleife;
      
   end SetsSortieren;

end EinlesenSetsLogik;
