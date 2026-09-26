with EinlesenAllgemeinesHTSEB;
with MeldungssystemHTSEB;

with Menuetexte;

package body EinlesenTextSonstigesLogik is

   procedure Ersetzungen
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean)
   is begin
      
      EinzulesendeZeile := 1;
      AktuelleZeile := 1;
      
      ErsetzungenSchleife:
      loop
         
         case
           EinlesenAllgemeinesHTSEB.VorzeitigesDateienende (AktuelleDateiExtern => DateiExtern,
                                                            AktuelleZeileExtern => EinzulesendeZeile,
                                                            DateinameExtern     => "EinlesenTextSonstigesLogik.Ersetzungen")
         is
            when True =>
               MeldungssystemHTSEB.Logik (MeldungExtern => "EinlesenTextSonstigesLogik.Ersetzungen: Einzulesende Zeile:" & EinzulesendeZeile'Wide_Wide_Image & ", aktuelle Zeile:" & AktuelleZeile'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := EinlesenAllgemeinesHTSEB.TextEinlesenUngebunden (DateiExtern         => DateiExtern,
                                                                                    AktuelleZeileExtern => EinzulesendeZeile,
                                                                                    DateinameExtern     => "EinlesenTextSonstigesLogik.Ersetzungen");
               EinzulesendeZeile := EinzulesendeZeile + 1;
         end case;
         
         case
           To_Wide_Wide_String (Source => Zwischenspeicher) (1)
         is
            when TextKonstantenHTSEB.TrennzeichenTextdateien =>
               null;
               
            when others =>
               ErsetzungenEingelesen (AktuelleZeile) := Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                     EingelesenerTextExtern => Zwischenspeicher,
                                                                     VorhandenerTextExtern  => ErsetzungenEingelesen (AktuelleZeile));
               
               if
                 AktuelleZeile < ErsetzungenEingelesenArray'Last
               then
                  AktuelleZeile := AktuelleZeile + 1;
                  
               else
                  return;
               end if;
         end case;
         
      end loop ErsetzungenSchleife;
      
   end Ersetzungen;
   
   
   
   function TextErsetzen
     (TextExtern : in Unbounded_Wide_Wide_String)
      return Unbounded_Wide_Wide_String
   is begin
      
      ErsetzungSchleife:
      for ErsetzungSchleifenwert in ErsetzungenEingelesenArray'Range loop
         
         if
           TextExtern = '~' & ZahlAlsString (ZahlExtern => ErsetzungSchleifenwert) & '~'
         then
            return ErsetzungenEingelesen (ErsetzungSchleifenwert);
            
         else
            null;
         end if;
         
      end loop ErsetzungSchleife;
        
      return TextExtern;
      
   end TextErsetzen;
   
   
   
   -- Das nach EinlesenAllgemeinesHTSEB verschieben? äöü
   -- Wird vermutlich nur hier jemals gebraucht werden, also hier lassen? äöü
   function Einsprachig
     (EinsprachigExtern : in Boolean;
      EingelesenerTextExtern : in Unbounded_Wide_Wide_String;
      VorhandenerTextExtern : in Unbounded_Wide_Wide_String)
      return Unbounded_Wide_Wide_String
   is begin
      
      case
        EinsprachigExtern
      is
         when True =>
            return EingelesenerTextExtern;
               
         when False =>
            if
              VorhandenerTextExtern = TextKonstantenHTSEB.FehlenderText
              or
                -- Sollte das nicht besser nach der grafischen Länge statt der Anzahl der Zeichen beurteilt werden? äöü
              To_Wide_Wide_String (Source => VorhandenerTextExtern)'Length < To_Wide_Wide_String (Source => EingelesenerTextExtern)'Length
            then
               return EingelesenerTextExtern;
                  
            else
               return VorhandenerTextExtern;
            end if;
      end case;
      
   end Einsprachig;
   
   
   
   procedure Debugmenü
   is begin
      
      Menuetexte.Debugmenü (1) := To_Unbounded_Wide_Wide_String (Source => "Debugmenü");
      Menuetexte.Debugmenü (2) := To_Unbounded_Wide_Wide_String (Source => "Karte aufdecken");
      Menuetexte.Debugmenü (3) := To_Unbounded_Wide_Wide_String (Source => "Alle Technologien");
      Menuetexte.Debugmenü (4) := To_Unbounded_Wide_Wide_String (Source => "Mensch/KI tauschen");
      Menuetexte.Debugmenü (5) := To_Unbounded_Wide_Wide_String (Source => "Diplomatischen Status ändern");
      Menuetexte.Debugmenü (6) := To_Unbounded_Wide_Wide_String (Source => "Volle Forschung");
      Menuetexte.Debugmenü (7) := To_Unbounded_Wide_Wide_String (Source => "Einheit erzeugen");
      Menuetexte.Debugmenü (8) := To_Unbounded_Wide_Wide_String (Source => "Einsprachig/Mehrsprachig");
      Menuetexte.Debugmenü (9) := To_Unbounded_Wide_Wide_String (Source => "Teststopp");
      Menuetexte.Debugmenü (10) := To_Unbounded_Wide_Wide_String (Source => "Eingelesene Texte ausgeben");
      Menuetexte.Debugmenü (11) := To_Unbounded_Wide_Wide_String (Source => "Fertig");
      
   end Debugmenü;

end EinlesenTextSonstigesLogik;
