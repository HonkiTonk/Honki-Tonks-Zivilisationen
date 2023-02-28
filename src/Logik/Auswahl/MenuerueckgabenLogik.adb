with Fehlermeldungssystem;
with OftVerwendetSound;

package body MenuerueckgabenLogik is
   
   function RückgabeMenüs
     (EndeExtern : in Positive;
      AktuelleAuswahlExtern : in Positive;
      WelchesMenüExtern : in MenueDatentypen.Menü_Ohne_Steuerung_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
      
      OftVerwendetSound.Klick;
      
      case
        WelchesMenüExtern
      is
         when MenueDatentypen.Haupt_Menü_Enum =>
            return Hauptmenü (EndeExtern            => EndeExtern,
                               AktuelleAuswahlExtern => AktuelleAuswahlExtern);
            
         when MenueDatentypen.Spiel_Menü_Enum =>
            return Spielmenü (EndeExtern            => EndeExtern,
                               AktuelleAuswahlExtern => AktuelleAuswahlExtern);
            
         when MenueDatentypen.Einstellungen_Menü_Enum =>
            return SpieleinstellungenMenü (EndeExtern            => EndeExtern,
                                            AktuelleAuswahlExtern => AktuelleAuswahlExtern);
            
         when MenueDatentypen.Kartenpole_Menü_Enum | MenueDatentypen.Kartengröße_Menü_Enum | MenueDatentypen.Kartenart_Menü_Enum | MenueDatentypen.Kartenform_Menü_Enum | MenueDatentypen.Kartentemperatur_Menü_Enum
            | MenueDatentypen.Kartenressourcen_Menü_Enum | MenueDatentypen.Schwierigkeitsgrad_Menü_Enum | MenueDatentypen.Spezies_Menü_Enum | MenueDatentypen.Debug_Menü_Enum =>
            MitFertig := True;
            
         when others =>
            MitFertig := False;
      end case;
      
      AuswahlSchleife:
      for AuswahlSchleifenwert in Anfang .. Menüende (WelchesMenüExtern) loop

         if
           AktuelleAuswahlExtern = AuswahlSchleifenwert
         then
            return RueckgabeDatentypen.Rückgabe_Werte_Enum'Val (Grundwert + AuswahlSchleifenwert);

         else
            null;
         end if;

      end loop AuswahlSchleife;
        
      return ZurückHauptmenüEnde (EndeExtern            => EndeExtern,
                                    AktuelleAuswahlExtern => AktuelleAuswahlExtern,
                                    FertigExtern          => MitFertig);
      
   end RückgabeMenüs;
   
   
   
   function SteuerungMenü
     (AnfangExtern : in Positive;
      EndeExtern : in Positive;
      AktuelleAuswahlExtern : in Positive)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
      
      if
        AktuelleAuswahlExtern = AnfangExtern
      then
         return RueckgabeDatentypen.Speichern_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 1
      then
         return RueckgabeDatentypen.Standard_Enum;
         
      else
         return ZurückHauptmenüEnde (EndeExtern            => EndeExtern,
                                       AktuelleAuswahlExtern => AktuelleAuswahlExtern,
                                       FertigExtern          => False);
      end if;
      
   end SteuerungMenü;
   
   

   function Hauptmenü
     (EndeExtern : in Positive;
      AktuelleAuswahlExtern : in Positive)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
            
      if
        AktuelleAuswahlExtern = Anfang
      then
         return RueckgabeDatentypen.Start_Weiter_Enum;
         
      elsif
        AktuelleAuswahlExtern = Anfang + 1
      then
         return RueckgabeDatentypen.Schnellstart_Enum;
                  
      elsif
        AktuelleAuswahlExtern = Anfang + 2
      then
         return RueckgabeDatentypen.Laden_Enum;
                    
      elsif
        AktuelleAuswahlExtern = Anfang + 3
      then
         return RueckgabeDatentypen.Optionen_Enum;
                    
      elsif
        AktuelleAuswahlExtern = Anfang + 4
      then
         return RueckgabeDatentypen.Editoren_Enum;
                    
      elsif
        AktuelleAuswahlExtern = Anfang + 5
      then
         return RueckgabeDatentypen.Würdigungen_Enum;
                    
      else
         return ZurückHauptmenüEnde (EndeExtern            => EndeExtern,
                                       AktuelleAuswahlExtern => AktuelleAuswahlExtern,
                                       FertigExtern          => False);
      end if;
      
   end Hauptmenü;
   
   
   
   function Spielmenü
     (EndeExtern : in Positive;
      AktuelleAuswahlExtern : in Positive)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
      
      if
        AktuelleAuswahlExtern = Anfang
      then
         return RueckgabeDatentypen.Start_Weiter_Enum;
                    
      elsif
        AktuelleAuswahlExtern = Anfang + 1
      then
         return RueckgabeDatentypen.Speichern_Enum;
                    
      elsif
        AktuelleAuswahlExtern = Anfang + 2
      then
         return RueckgabeDatentypen.Laden_Enum;
                    
      elsif
        AktuelleAuswahlExtern = Anfang + 3
      then
         return RueckgabeDatentypen.Optionen_Enum;
                    
      else
         return ZurückHauptmenüEnde (EndeExtern            => EndeExtern,
                                       AktuelleAuswahlExtern => AktuelleAuswahlExtern,
                                       FertigExtern          => False);
      end if;
      
   end Spielmenü;
   
   
   
   function SpieleinstellungenMenü
     (EndeExtern : in Positive;
      AktuelleAuswahlExtern : in Positive)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
      
      if
        AktuelleAuswahlExtern = Anfang
      then
         return RueckgabeDatentypen.Auswahl_Eins_Enum;
      
      elsif
        AktuelleAuswahlExtern = Anfang + 1
      then
         return RueckgabeDatentypen.Auswahl_Zwei_Enum;
                    
      elsif
        AktuelleAuswahlExtern = Anfang + 2
      then
         return RueckgabeDatentypen.Auswahl_Drei_Enum;
                    
      elsif
        AktuelleAuswahlExtern = Anfang + 3
      then
         return RueckgabeDatentypen.Auswahl_Vier_Enum;
                    
      elsif
        AktuelleAuswahlExtern = Anfang + 4
      then
         return RueckgabeDatentypen.Auswahl_Fünf_Enum;
         
      elsif
        AktuelleAuswahlExtern = Anfang + 5
      then
         return RueckgabeDatentypen.Auswahl_Sechs_Enum;
         
      elsif
        AktuelleAuswahlExtern = Anfang + 6
      then
         return RueckgabeDatentypen.Auswahl_Sieben_Enum;
         
      elsif
        AktuelleAuswahlExtern = Anfang + 7
      then
         return RueckgabeDatentypen.Auswahl_Acht_Enum;
         
      elsif
        AktuelleAuswahlExtern = Anfang + 8
      then
         return RueckgabeDatentypen.Fertig_Enum;
                    
      else
         return ZurückHauptmenüEnde (EndeExtern            => EndeExtern,
                                       AktuelleAuswahlExtern => AktuelleAuswahlExtern,
                                       FertigExtern          => False);
      end if;
      
   end SpieleinstellungenMenü;
   
   
   
   function Fertig
     (EndeExtern : in Positive;
      AktuelleAuswahlExtern : in Positive)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
      
      if
        AktuelleAuswahlExtern = EndeExtern
      then
         return RueckgabeDatentypen.Fertig_Enum;
                    
      else
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "MenuerueckgabenLogik.Fertig: Falsche Auswahl");
         return RueckgabeDatentypen.Spiel_Beenden_Enum;
      end if;
      
   end Fertig;
        
   
   
   function ZurückHauptmenüEnde
     (EndeExtern : in Positive;
      AktuelleAuswahlExtern : in Positive;
      FertigExtern : in Boolean)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
      
      case
        FertigExtern
      is
         when True =>
            return RueckgabeDatentypen.Fertig_Enum;
            
         when False =>
            if
              AktuelleAuswahlExtern = EndeExtern - 2
            then
               return RueckgabeDatentypen.Zurück_Enum;
                    
            elsif
              AktuelleAuswahlExtern = EndeExtern - 1
            then
               return RueckgabeDatentypen.Hauptmenü_Enum;
                    
            elsif
              AktuelleAuswahlExtern = EndeExtern
            then
               return RueckgabeDatentypen.Spiel_Beenden_Enum;
                    
            else
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "MenuerueckgabenLogik.ZurückHauptmenüEnde: Falsche Auswahl");
               return RueckgabeDatentypen.Spiel_Beenden_Enum;
            end if;
      end case;
      
   end ZurückHauptmenüEnde;

end MenuerueckgabenLogik;
