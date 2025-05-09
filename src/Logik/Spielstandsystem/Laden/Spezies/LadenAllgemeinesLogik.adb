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
            
      SystemDatentypen.EinByte'Read (Stream (File => DateiLadenExtern),
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
         MeldungssystemHTSEB.Logik (MeldungExtern => "LadenAllgemeinesLogik.Allgemeines: Konnte nicht geladen werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
         
   end Allgemeines;
   
   
   
   function Speziesbelegung
     (LadenPrüfenExtern : in Boolean;
      DateiLadenExtern : in File_Type)
      return Boolean
   is
      use Ada.Exceptions;
      use type SystemDatentypen.EinByte;
   begin
      
      BereichSchleife:
      for BereichSchleifenwert in SpeziesKonstanten.SpeziesanfangLadenSpeichernArray'Range loop
         SpeziesbelegungSchleife:
         for SpeziesbelegungSchleifenwert in SpeziesKonstanten.SpeziesanfangSpeichernLaden (BereichSchleifenwert) .. SpeziesKonstanten.SpeziesendeSpeichernLaden (BereichSchleifenwert) loop
              
            SpeziesDatentypen.Spieler_Enum'Read (Stream (File => DateiLadenExtern),
                                                 Belegung (SpeziesbelegungSchleifenwert).Belegung);
            
         end loop SpeziesbelegungSchleife;
      
         SystemDatentypen.EinByte'Read (Stream (File => DateiLadenExtern),
                                        Besiegt);
         
         SpeziesBesiegtSchleife:
         for SpeziesBesiegtSchleifenwert in reverse SpeziesKonstanten.SpeziesanfangSpeichernLaden (BereichSchleifenwert) .. SpeziesKonstanten.SpeziesendeSpeichernLaden (BereichSchleifenwert) loop
              
            Potenz := SpeziesDatentypen.Spezies_Vorhanden_Enum'Pos (SpeziesBesiegtSchleifenwert) - SpeziesDatentypen.Spezies_Vorhanden_Enum'Pos (SpeziesKonstanten.SpeziesanfangSpeichernLaden (BereichSchleifenwert));
            
            if
              Integer (Besiegt) - Potenz >= 0
            then
               Belegung (SpeziesBesiegtSchleifenwert).Besiegt := True;
               Besiegt := Besiegt - 2**Potenz;
               
            else
               Belegung (SpeziesBesiegtSchleifenwert).Besiegt := False;
            end if;
            
         end loop SpeziesBesiegtSchleife;
      end loop BereichSchleife;
            
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
         MeldungssystemHTSEB.Logik (MeldungExtern => "LadenAllgemeinesLogik.Speziesbelegung: Konnte nicht geladen werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end Speziesbelegung;

end LadenAllgemeinesLogik;
