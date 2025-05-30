with Ada.Exceptions;

with MeldungssystemHTSEB;
with UmwandlungssystemHTSEB;

with SpeziesKonstanten;

with SchreibeAllgemeines;
with SchreibeSpeziesbelegung;

with SpielstandAllgemeinesLogik;

package body LadenAllgemeinesLogik is
   
   function Aufteilung
     (LadenPrüfenExtern : in Boolean;
      DateiLadenExtern : in File_Type)
      return Boolean
   is begin
      
      case
        Allgemeines (LadenPrüfenExtern => LadenPrüfenExtern,
                     DateiLadenExtern  => DateiLadenExtern)
      is
         when False =>
            return False;
            
         when True =>
            return Speziesbelegung (LadenPrüfenExtern => LadenPrüfenExtern,
                                    DateiLadenExtern  => DateiLadenExtern);
      end case;
      
   end Aufteilung;
   
   

   function Allgemeines
     (LadenPrüfenExtern : in Boolean;
      DateiLadenExtern : in File_Type)
      return Boolean
   is
      use Ada.Exceptions;
   begin
            
      SystemDatentypenHTSEB.EinByte'Read (Stream (File => DateiLadenExtern),
                                          GewonnenWeiterspielen);
      
      case
        GewonnenWeiterspielen
      is
         when 1 =>
            Gewonnen := True;
            Weiterspielen := False;
            
         when 2 =>
            Weiterspielen := True;
            Gewonnen := False;
            
         when 3 =>
            Gewonnen := True;
            Weiterspielen := True;
            
         when others =>
            Gewonnen := False;
            Weiterspielen := False;
      end case;
      
      SpeziesDatentypen.Spezies_Enum'Read (Stream (File => DateiLadenExtern),
                                           SpezieszugNachLaden);
      
      SpielDatentypen.Schwierigkeitsgrad_Enum'Read (Stream (File => DateiLadenExtern),
                                                    Schwierigkeitsgrad);
      
      ZahlenDatentypen.EigenesPositive'Read (Stream (File => DateiLadenExtern),
                                             Rundenanzahl);
      
      ZahlenDatentypen.EigenesNatural'Read (Stream (File => DateiLadenExtern),
                                            Rundengrenze);
      
      Unbounded_Wide_Wide_String'Read (Stream (File => DateiLadenExtern),
                                       Ironman);
      
      SpeziesDatentypen.Spezies_Enum'Read (Stream (File => DateiLadenExtern),
                                           PlanetVernichtet);
      
      ZahlenDatentypen.EigenerInteger'Read (Stream (File => DateiLadenExtern),
                                            Zusammenbruchszeit);
      
      ZahlenDatentypen.EigenesNatural'Read (Stream (File => DateiLadenExtern),
                                            EingesetztePZB);
      
      case
        LadenPrüfenExtern
      is
         when True =>
            SchreibeAllgemeines.GanzerEintrag (EintragExtern => (Gewonnen            => Gewonnen,
                                                                 Weiterspielen       => Weiterspielen,
                                                                 SpezieszugNachLaden => SpezieszugNachLaden,
                                                                 Schwierigkeitsgrad  => Schwierigkeitsgrad,
                                                                 Rundenanzahl        => Rundenanzahl,
                                                                 Rundengrenze        => Rundengrenze,
                                                                 IronmanName         => Ironman,
                                                                 PlanetVernichtet    => PlanetVernichtet,
                                                                 Zusammenbruchszeit  => Zusammenbruchszeit,
                                                                 EingesetztePZB      => EingesetztePZB));
            
         when False =>
            null;
      end case;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "LadenAllgemeinesLogik.Allgemeines: Konnte nicht geladen werden: LadenPrüfenExtern = " & LadenPrüfenExtern'Wide_Wide_Image & " "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
         
   end Allgemeines;
   
   
   
   function Speziesbelegung
     (LadenPrüfenExtern : in Boolean;
      DateiLadenExtern : in File_Type)
      return Boolean
   is
      use Ada.Exceptions;
      use type SystemDatentypenHTSEB.EinByte;
   begin
      
      Belegung := (others => (Belegung => SpeziesDatentypen.Leer_Spieler_Enum,
                              Besiegt  => False));
      
      BelegungSchleife:
      for BelegungSchleifenwert in SpeziesDatentypen.Spezies_Vorhanden_Enum'Range loop
         
         SpeziesDatentypen.Spieler_Enum'Read (Stream (File => DateiLadenExtern),
                                              Belegung (BelegungSchleifenwert).Belegung);
         
      end loop BelegungSchleife;
      
      SpielstandAllgemeinesLogik.SpeziesbelegungSchreiben (SpeziesbelegungExtern => Belegung);
      
      SpeziesVorhanden := SpielstandAllgemeinesLogik.GesamteSpeziesanzahl (SpeichernLadenExtern => False);
      
      SystemDatentypenHTSEB.EinByte'Read (Stream (File => DateiLadenExtern),
                                          Besiegt (1));
      
      case
        SpeziesVorhanden
      is
         when 0 =>
            return False;
            
         when 9 .. 16 =>
            AktuellerArraybereich := 2;
            
            SystemDatentypenHTSEB.EinByte'Read (Stream (File => DateiLadenExtern),
                                                Besiegt (2));
            
         when 17 .. SpeziesKonstanten.Speziesende =>
            AktuellerArraybereich := 3;
            
            SystemDatentypenHTSEB.EinByte'Read (Stream (File => DateiLadenExtern),
                                                Besiegt (2));
            SystemDatentypenHTSEB.EinByte'Read (Stream (File => DateiLadenExtern),
                                                Besiegt (3));
            
         when others =>
            AktuellerArraybereich := 1;
      end case;
      
      BesiegtSchleife:
      for BesiegtSchleifenwert in reverse SpeziesDatentypen.Spezies_Vorhanden_Enum'Range loop
         
         case
           Belegung (BesiegtSchleifenwert).Belegung
         is
            when SpeziesDatentypen.Leer_Spieler_Enum =>
               null;
               
            when others =>
               Potenz := (SpeziesVorhanden - 1) mod 8;
         
               if
                 Besiegt (AktuellerArraybereich) >= 2**Potenz
               then
                  Belegung (BesiegtSchleifenwert).Besiegt := True;
                  Besiegt (AktuellerArraybereich) := Besiegt (AktuellerArraybereich) - 2**Potenz;
               
               else
                  null;
               end if;
               
               SpeziesVorhanden := SpeziesVorhanden - 1;
               
               if
                 SpeziesVorhanden = 0
               then
                  exit BesiegtSchleife;
                  
               elsif
                 SpeziesVorhanden = 16
                 or
                   SpeziesVorhanden = 8
               then
                  AktuellerArraybereich := AktuellerArraybereich - 1;
                  
               else
                  null;
               end if;
         end case;
         
      end loop BesiegtSchleife;
      
      case
        LadenPrüfenExtern
      is
         when True =>
            SchreibeSpeziesbelegung.GanzesArray (ArrayExtern => Belegung);
            
         when False =>
            SpielstandAllgemeinesLogik.SpeziesbelegungSchreiben (SpeziesbelegungExtern => Belegung);
      end case;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "LadenAllgemeinesLogik.Speziesbelegung: Konnte nicht geladen werden: LadenPrüfenExtern = " & LadenPrüfenExtern'Wide_Wide_Image & " "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end Speziesbelegung;

end LadenAllgemeinesLogik;
