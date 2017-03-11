{-# LANGUAGE DuplicateRecordFields #-}

import Data.Map

data GetArgs = GetArgs {
  get :: String,
  resource :: Maybe String,
  version :: Maybe String,
  passed :: Maybe [String],
  params :: Maybe (Map String String),
  trigger :: Maybe Bool
} deriving (Show, Eq)

data PutArgs = PutArgs {
  put :: String,
  resource :: Maybe String,
  params :: Maybe (Map String String),
  getParams :: Maybe (Map String String)
} deriving (Show, Eq)

newtype FilePathString = FP String deriving (Show, Eq)

data TaskArgs = TaskArgs {
  task :: String,
  body :: Either FilePathString Step,
  get :: Maybe String, -- Sets file for some reason
  privileged :: Maybe Bool,
  params :: Maybe (Map String String),
  image :: Maybe String,
  inputMapping :: Maybe (Map String String),
  outputMapping :: Maybe (Map String String)
} deriving (Eq, Show)

data ModifierArgs = ModifierArgs {
  onSuccess :: Maybe Step,
  onFailure :: Maybe Step,
  ensure :: Maybe Step,
  tags :: Maybe [String],
  timeout :: Maybe Int,
  attempts :: Maybe Int
} deriving (Show, Eq)

data Step = Get GetArgs ModifierArgs |
            Put PutArgs ModifierArgs |
            Task TaskArgs ModifierArgs |
            Do [Step] ModifierArgs |
            Aggregate [Step] ModifierArgs
            deriving (Eq, Show)
