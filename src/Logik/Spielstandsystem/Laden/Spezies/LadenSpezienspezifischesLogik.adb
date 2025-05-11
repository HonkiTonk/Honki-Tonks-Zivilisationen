with Ada.Exceptions;

with MeldungssystemHTSEB;
with UmwandlungssystemHTSEB;

with ForschungKonstanten;

with SchreibeGrenzen;
with SchreibeWichtiges;
with SchreibeZeiger;

with SpielstandAllgemeinesLogik;

package body LadenSpezienspezifischesLogik is

   function Aufteilung
     (LadenPrüfenExtern : in Boolean;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      DateiLadenExtern : in File_Type)
      return Boolean
   is begin
      
      case
        Grenzen (LadenPrüfenExtern => LadenPrüfenExtern,
                 SpeziesExtern     => SpeziesExtern,
                 DateiLadenExtern  => DateiLadenExtern)
      is
         when False =>
            return False;
            
         when True =>
            return Wichtiges (LadenPrüfenExtern => LadenPrüfenExtern,
                              SpeziesExtern     => SpeziesExtern,
                              DateiLadenExtern  => DateiLadenExtern);
      end case;
      
   end Aufteilung;
   
   
   
   function Grenzen
     (LadenPrüfenExtern : in Boolean;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      DateiLadenExtern : in File_Type)
      return Boolean
   is
      use Ada.Exceptions;
   begin
      
      SpielRecords.GrenzenRecord'Read (Stream (File => DateiLadenExtern),
                                       AlleGrenzen);
      
      case
        LadenPrüfenExtern
      is
         when True =>
            SchreibeGrenzen.GanzerEintrag (SpeziesExtern => SpeziesExtern,
                                           EintragExtern => AlleGrenzen);
            
         when False =>
            null;
      end case;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "LadenSpezienspezifischesLogik.Grenzen: Konnte nicht geladen werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end Grenzen;
   
   
   
   function Wichtiges
     (LadenPrüfenExtern : in Boolean;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      DateiLadenExtern : in File_Type)
      return Boolean
   is
      use Ada.Exceptions;
      use type SystemDatentypen.VierByte;
   begin
      
      ZahlenDatentypen.EigenerInteger'Read (Stream (File => DateiLadenExtern),
                                            Geldmenge);
      
      -- Das hier, und eventuell auch andere Sachen, weglassen und einfach neu berechnen nach dem Laden? äöü
      ProduktionDatentypen.Produktion'Read (Stream (File => DateiLadenExtern),
                                            GeldRundengewinn);
      
      -- Das hier, und eventuell auch andere Sachen, weglassen und einfach neu berechnen nach dem Laden? äöü
      ProduktionDatentypen.Lagermenge'Read (Stream (File => DateiLadenExtern),
                                            GesamteForschungsrate);
      
      ProduktionDatentypen.Lagermenge'Read (Stream (File => DateiLadenExtern),
                                            Forschungsmenge);
      
      -- Das hier, und eventuell auch andere Sachen, weglassen und einfach neu berechnen nach dem Laden? äöü
      ProduktionDatentypen.Lagermenge'Read (Stream (File => DateiLadenExtern),
                                            VerbleibendeForschungszeit);
      
      ForschungenDatentypen.ForschungID'Read (Stream (File => DateiLadenExtern),
                                              Forschungsprojekt);
      
      -- Solle sich die Anzahl der Forschungen nicht zu weit erhöhen könnte man das auch als 2 statt 4 Bytes speichern und noch einmal 2 Byte pro Speicherung sparen.
      BereichSchleife:
      for BereichSchleifenwert in ForschungKonstanten.ForschungsbereichArray'Range loop
                  
         SystemDatentypen.VierByte'Read (Stream (File => DateiLadenExtern),
                                         ForschungVorhanden);
         
         ForschungSchleife:
         for ForschungSchleifenwert in reverse ForschungKonstanten.Forschunganfang (BereichSchleifenwert) .. ForschungKonstanten.Forschungsende (BereichSchleifenwert) loop
         
            Potenz := Positive (ForschungSchleifenwert) - Positive (ForschungKonstanten.Forschunganfang (BereichSchleifenwert));
            
            if
              ForschungVorhanden >= SystemDatentypen.VierByte (2**Potenz)
            then
               Erforscht (ForschungSchleifenwert) := True;
               ForschungVorhanden := ForschungVorhanden - SystemDatentypen.VierByte (2**Potenz);
               
            else
               Erforscht (ForschungSchleifenwert) := False;
            end if;
         
         end loop ForschungSchleife;
      end loop BereichSchleife;
            
      StadtDatentypen.Städtebereich'Read (Stream (File => DateiLadenExtern),
                                           AnzahlStädte);
      
      EinheitenDatentypen.Einheitenbereich'Read (Stream (File => DateiLadenExtern),
                                                 AnzahlArbeiter);
      
      EinheitenDatentypen.Einheitenbereich'Read (Stream (File => DateiLadenExtern),
                                                 AnzahlKämpfer);
      
      EinheitenDatentypen.Einheitenbereich'Read (Stream (File => DateiLadenExtern),
                                                 AnzahlSonstiges);
      
      case
        SpielstandAllgemeinesLogik.SpeziesbelegungLesen (SpeziesExtern => SpeziesExtern)
      is
         when SpeziesDatentypen.Mensch_Spieler_Enum =>
            KartenRecords.ZeigerRecord'Read (Stream (File => DateiLadenExtern),
                                             Zeiger);
            
         when others =>
            null;
      end case;
      
      case
        LadenPrüfenExtern
      is
         when True =>
            SchreibeWichtiges.GanzerEintrag (SpeziesExtern => SpeziesExtern,
                                             EintragExtern => (Geldmenge                  => Geldmenge,
                                                               GeldRundengewinn           => GeldRundengewinn,
                                                               GesamteForschungsrate      => GesamteForschungsrate,
                                                               Forschungsmenge            => Forschungsmenge,
                                                               VerbleibendeForschungszeit => VerbleibendeForschungszeit,
                                                               Forschungsprojekt          => Forschungsprojekt,
                                                               Erforscht                  => Erforscht,
                                                               AnzahlStädte               => AnzahlStädte,
                                                               AnzahlArbeiter             => AnzahlArbeiter,
                                                               AnzahlKämpfer              => AnzahlKämpfer,
                                                               AnzahlSonstiges            => AnzahlSonstiges));
            
            case
              SpielstandAllgemeinesLogik.SpeziesbelegungLesen (SpeziesExtern => SpeziesExtern)
            is
               when SpeziesDatentypen.Mensch_Spieler_Enum =>
                  SchreibeZeiger.GanzerEintrag (SpeziesExtern => SpeziesExtern,
                                                EintragExtern => Zeiger);
            
               when others =>
                  null;
            end case;
            
         when False =>
            null;
      end case;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "LadenSpezienspezifischesLogik.Wichtiges: Konnte nicht geladen werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end Wichtiges;

end LadenSpezienspezifischesLogik;
